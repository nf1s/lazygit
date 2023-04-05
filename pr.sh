#!/usr/bin/env bash
set -e
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

if [[ $JIRA_TICKET != CORE* ]]; then
  echo "🚫 Jira ticket must start with CORE 🚫"
  exit
fi

echo "✅ Generating changes from commits. 📒 "
CHANGES=`git log master.. --pretty=oneline --pretty=format:'- %s%b.'`

echo "✅ Generating pull request template. 📖 "
BODY=$(sed -e "s/\&JIRA_TICKET/$JIRA_TICKET/g; s/\&DESCRIPTION/$DESCRIPTION/g; s/\&CHANGES/${CHANGES//$'\n'/\\$'\n'}/g;" $FILE_PATH)

git push -u origin HEAD
gh pr create -t "[$JIRA_TICKET]/$BRANCH_TYPE/$BRANCH_NAME" -d -b "$BODY"
gh pr view --web
