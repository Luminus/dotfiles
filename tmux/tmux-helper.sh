#!/bin/sh
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice

case $1 in
  launch-shell)
    if [ "`uname`" = "Darwin" ]; then
      export PATH=$PATH:`cat ~/.dotfiles_location`/bin/tmux-osx-paste-fix
      if [ -x "`which reattach-to-user-namespace`" ]; then
        reattach-to-user-namespace -l $2
      else
        echo "install reattach-to-user-namespace!"
        $2
      fi
    else
      $2
    fi ;;

  battery)
    if [ -e "$HOME/Code/dotfiles/bin/battery/battery" ]; then
      $HOME/Code/dotfiles/bin/battery/battery tmux
    fi ;;

  top) if [ -x "`which htop`" ]; then htop; else top; fi ;;

  copy-buf) if [ -x "`which reattach-to-user-namespace`" ] && [ -x "`which pbcopy`" ]; then
    tmux save-buffer - | reattach-to-user-namespace pbcopy
  elif [ -x "`which xclip`" ]; then
    tmux save-buffer - | xclip
  else
    echo "Copy not supported"
  fi ;;

  copy-pipe) if [ -x "`which reattach-to-user-namespace`" ] && [ -x "`which pbcopy`" ]; then
    reattach-to-user-namespace pbcopy
  elif [ -x "`which xclip`" ]; then
    xclip
  else
    echo "Copy not supported"
  fi ;;
  *) echo "Unknown command";;
esac