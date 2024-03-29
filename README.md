# dotfiles
This is a repository for all of my dotfiles.

# Installation
* `cd ~/`
* `git init`
* `git remote add origin https://github.com/simonkir/dotfiles.git`
* `git fetch --all`
* `git reset --hard origin/master`

# Configuration
* `git config --local status.showUntrackedFiles no` hides untracked files
* `git config --local core.fileMode false` hides files with permission changes
* `git update-index --(no-)assume-unchanged [<file>]` don't show changes in tracked file <file>
* `git update-index --(no-)skip-worktree [<file>]` don't show changes in tracked file <file>

## further documentation (a bit messy)
* [bare repo: medium.com](https://medium.com/toutsbrasil/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b)
* [bare repo: Atlassian Tutorials](https://www.atlassian.com/git/tutorials/dotfiles)
* [bare repo: Arch Wiki](https://wiki.archlinux.org/index.php/Dotfiles)
* [conversion: Stackexchange](https://emacs.stackexchange.com/questions/30602/use-nonstandard-git-directory-with-magit)
* [conversion: Stackoverflow](https://stackoverflow.com/questions/10637378/how-do-i-convert-a-bare-git-repository-into-a-normal-one-in-place)

for further documentation.
