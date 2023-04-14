# Lazygit

## Features

- conventional commits.
- PR creation from template.

## Usage

- `c` to create commits with conventional commits. (must be in files context)
- `b` create a pull request from template, then open the pr in a new window
- `v` view pr in web browser (must be in localBranches context)

## Setup

```bash
$ git clone https://github.com/nf1s/lazygit.git ~/.config/lazygit
```

## Configure

```
$ touch config.cfg
```

### Add your Jira ticket prefix to `config.cfg`

```bash
# Jira tickets are usually prefixed with the project name, e.g. "ABC-1234".
# In this case, the JIRA_TICKET_PREFIX should be set to is "ABC".
# We can add multiple prefixes by separating them with a comma, e.g. "ABC,DEF"
# JIRA_TICKET_PREFIX is case insensitive.
# JIRA_COMPANY is your Jira workspace usually like `your_company.atlassian.net`
# In this case, JIRA_COMPANY=your_company
CHECK_JIRA_TICKET_PREFIX=true
JIRA_TICKET_PREFIX=core,Ops
JIRA_COMPANY=your_company
```

## Start

```bash
$ lazygit -ucd ~/.config/lazygit
```

If you use zsh, add alias to your .zshrc

```bash
alias lazygit="lazygit -ucd ~/.config/lazygit"
```

```bash
$ lazygit
```

## Example

### Creating a new branch

- Go to the local branches context and press `n`

![image new_branch](./assets/0.new_branch.png)

- Add branch_name

![image branch_name](./assets/1.branch_name.png)

- Create a new file `test.json`

![image create_file](./assets/2.create_file.png)

- Add to some data to the file

![image add_contents_to_file](./assets/3.add_contents_to_file.png)

- Press `Space` to stage the file

![image stage_file](./assets/4.stage_file.png)

- Add commit message

![image add_commit_message](./assets/5.add_commit_message.png)

- Check commit log

![image check_commit_log](./assets/6.check_commit_log.png)

- While in the Files or Branches context press `b` to create a new PR

![image create_pr](./assets/7.create_pr.png)

- Add Jira ticket number

![image add_jira_ticket](./assets/8.add_jira_ticket_number.png)

- Lazygit will automatically create a PR from template.
- Will automatically open the browser for the PR.

![image add_jira_ticket](./assets/9.end_result.png)
