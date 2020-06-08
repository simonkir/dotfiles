# dotfiles
This is a repository for all of my dotfiles.

# Usage
## Configuration specific
Documentation on specific applications can be found in `documentation/`

## How this repository works
See
* [medium.com](https://medium.com/toutsbrasil/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b)
* [Atlassian Tutorials](https://www.atlassian.com/git/tutorials/dotfiles)
* [Arch Wiki](https://wiki.archlinux.org/index.php/Dotfiles)

for some documentation.

# Tips & Tricks
## `update.sh`
- found in `~/documentation/update.sh`
- updates permissions for some scripts
- compiles some configs (e. g. i3 config)

## Hide untracked files
* `git-dtf config --local status.showUntrackedFiles no`

## Hide files with changes permissions
* `git-dtf config --local core.fileMode false`
