# dotfiles
This is a repository for all of my dotfiles.

# Installation
* `git clone --bare https://github.com/simonkir/dotfiles.git $HOME/dotfiles`
* `git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' checkout`
* `echo "gitdir: ./dotfiles" > .git`
* `cd dotfiles`
* `git config --local --bool core.bare false`
* `git config --local core.worktree ~/`

## further documentation
* [bare repo: medium.com](https://medium.com/toutsbrasil/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b)
* [bare repo: Atlassian Tutorials](https://www.atlassian.com/git/tutorials/dotfiles)
* [bare repo: Arch Wiki](https://wiki.archlinux.org/index.php/Dotfiles)
* [conversion: Stackexchange](https://emacs.stackexchange.com/questions/30602/use-nonstandard-git-directory-with-magit)
* [conversion: Stackoverflow](https://stackoverflow.com/questions/10637378/how-do-i-convert-a-bare-git-repository-into-a-normal-one-in-place)

for further documentation.

# Usage
## Configuration specific
Documentation on specific applications can be found in `documentation/`

# Tips & Tricks
## `update.sh`
- found in `~/documentation/update.sh`
- updates permissions for some scripts
- compiles some configs (e. g. i3 config)

## Hide untracked files
* `git config --local status.showUntrackedFiles no`

## Hide files with changed permissions
* `git config --local core.fileMode false`
