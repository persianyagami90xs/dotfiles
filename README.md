This repository contains a setup for dotfiles that *suits me*. In particular in contains:

 * A getting started guide (for a new machine) assuming Ubuntu 14.04
 * Vim with many plugins
 * Xmonad with keybindings convenient for Colemak users.

I think it's a bit bloated right now and wouldn't recommend it. One nice thing
with my dotfiles is that most lines are well documented.

## Getting started on a 14.04 machine

```{bash}
cd
sudo echo hi

# Things that are sensible to have without any explenation.
#
# Explenations
# ------------
# vim-gnome: Allows copy/paste from clipboard registers
# suckless-tools: Contains slock, for the blue dead simple screen locker
sudo apt-get install git vim zsh vim-gnome keychain silversearcher-ag xmonad suckless-tools

# More dependencies, a bit more bloated dependencies
#
# Explenations
# ------------
# ghc, cabal and zlib1g-dev: For antigen-hs
# nemo: It was in my .xsession file. Dunno if we still prefer over nautilus
# cmake, g++ and python-dev:
# exuberant-ctags: Some vim-plugins wants it
sudo apt-get install ghc cabal-install zlib1g-dev nemo gnome-open-terminal cmake g++ python-dev xdotool exuberant-ctags

# More crap for nowadays bloated antigen-hs
cabal install cabal-install  # (requires zlib1g-dev)
cabal install 'process >= 1.2'

# Ok, now we can get the dotfiles...
# --recursive to get stuff like antigen-hs submodule
git clone --recursive https://github.com/Tarrasch/dotfiles.git

# Neobundle installation
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# Fix so that LightDM (Ubuntu login thingie) shows "Load ~/.xsession" as one of
# the "theme" options among things like Ubuntu Unity.
#
# The .xsession file itself will be synced from this dotfile repo
#
# References
# http://manpages.ubuntu.com/manpages/utopic/man5/Xsession.5.html
# https://wiki.ubuntu.com/CustomXSession#LightDM_configuration (LightDM config section)
sudo cp ~/dotfiles/.files/custom.desktop /usr/share/xsessions/custom.desktop

##### Git config
# This old gist is kind of related, but nowadays outdated I'll try to keep
# these following lines to be the real source of truth.
#
# https://gist.github.com/Tarrasch/40bf9892342cce7efe8a
git config --global core.excludesfile ~/.gitignore-global
git config --global core.pager 'less -+$LESS -R'

##### Fix fonts for vim-airline
fc-cache -vf ~/.fonts

# After fixing your keyboard layout to colemak. Do it also at the "system
# level". Otherwise you'll have this annoying bug where the layouts are different
# for laptop and USB-keyboard.
sudo dpkg-reconfigure keyboard-configuration


# Now we can run ./.run.sh
# It contains partially automatic and partially interactive instructions
cd ~/dotfiles
./.run.sh
```

More thing to do include:

  * gnome-terminal:
    * Installing Solarized. [Link](https://github.com/Anthony25/gnome-terminal-colors-solarized)
    * Select airline font to "Ubuntu blah airline blah" in gnome-terminal. The
      `./.run.sh` automatically adds the selectable option though.
  * Start zsh -- install zsh plugins
  * Start vim -- install vim plugins
  * `chsh --shell /usr/bin/zsh` (Requires re-login!)
  * Relogin to see if chsh/xmonad works.
  * Create [ssh keys](https://help.github.com/articles/generating-ssh-keys/#platform-linux)
  * Add git info `git config --global ...`
