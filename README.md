# Lazygit

## Features

- conventional commits.
- PR creation from template.

## Usage

- `c` to create commits with conventional commits. (must be in files context)
- `b` create a pull request from template, then open the pr in a new window
- `v` view pr in web browser (must be in localbranches context)

## Setup

```bash
$ git clone https://github.com/nf1s/lazygit.git ~/.config/lazygit
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
