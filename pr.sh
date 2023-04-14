#!/usr/bin/env bash
set -e
source $HOME/.config/lazygit/config.cfg
FILE_PATH=$HOME/.config/lazygit/pr.md
BRANCH_NAME=$(git branch --show-current)


if [ "$1" = "" ]
then
  echo "Usage: $0 missing branch type"
  exit
fi

if [ "$2" = "" ]
then
  echo "Usage: $0 missing JIRA ticket number"
  exit
fi

if [ "$3" = "" ]
then
  echo "Usage: $0 missing description"
  exit
fi

BRANCH_TYPE=$1
JIRA_TICKET=$(echo "$2" | tr '[:lower:]' '[:upper:]')
DESCRIPTION=$3
IFS=',' read -ra ALLOWED_TICKETS <<< "$JIRA_TICKET_PREFIX"

if [[ $CHECK_JIRA_TICKET_PREFIX ]]; then
  found=false
  for f in "${ALLOWED_TICKETS[@]}" ;do
    f=$(echo "$2" | tr '[:lower:]' '[:upper:]')
    if [[ $JIRA_TICKET == $f* ]]; then
      found=true
      break
    fi
  done
  if ! $found; then
        echo "🚫 Jira ticket must start with CORE 🚫"
        exit 1
  fi
fi


CHANGES=`git log master.. --pretty=oneline --pretty=format:'- %s%b.'`
CHANGES=${CHANGES//$'\n'/'<NEWLINE_PLACEHOLDER>'}

echo "✅ Generated changes from commits. 📒 "

BODY=$(awk \
  -v jira_company="$JIRA_COMPANY" \
  -v jira_ticket="$JIRA_TICKET" \
  -v description="$DESCRIPTION" \
  -v changes="$CHANGES" '{
gsub(/<JIRA_COMPANY>/, jira_company);
gsub(/<JIRA_TICKET>/, jira_ticket);
gsub(/<DESCRIPTION>/, description);
gsub(/<CHANGES>/, changes);
printf "%s\n", $0
}' "$FILE_PATH")

BODY=${BODY//'<NEWLINE_PLACEHOLDER>'/$'\n'}

echo " ✅ Generating pull request template. 📖 "

git push -u origin HEAD
gh pr create -t "[$JIRA_TICKET]/$BRANCH_TYPE/$BRANCH_NAME" -d -b "$BODY"
gh pr view --web
