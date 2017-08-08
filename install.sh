# should use zsh

CMDNAME=`basename $0`

while getopts v:z: OPT
do
  case $OPT in
    "v") FLG_V = "TRUE" ;;
    "z") FLG_Z = "TRUE" ;;
     * )  echo "USEGE: $CMDNAME [-v] [-z]" 1>&2
          exit 1 ;;
  esac
done

if [ "$FLG_Z" = "TRUE" ]; then

  echo -e "\e[31;1;4mset zshrc\e[m"
  cp ./.zshrc ~/

  if [ -d ~/.zplug ]; then
    echo -e "\e[35;1;4mzplug\e[m \e[33;1mis already installed.\e[m"
  else
    echo -e "\e[32;1mInstall\e[m \e[35;1;4mzplug\e[m\e[32;1m.!!!\e[m"
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
  fi
fi

if [ "$FLG_V" = "TRUE" ]; then

  echo -e "\e[31;1;4mset vimrc\e[m"
  cp ./.vimrc ~/

  if [ -d ~/.vim/bundle ]; then
    echo -e "\e[35;1;4m~/.vim/bundle\e[m \e[33;1mis already created,\e[m"
  else  
    echo -e "\e[31;1mcreate ~/.vim/bundle\e[m"
    mkdir -p ~/.vim/bundle

    echo -e "\e[32;1mInstall\e[m \e[37;1;4mdein\e[m"
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
    sh ./installer.sh ~/.vim/bundle

    echo -e "\e[36;1mClean~~~\e[m"
    rm ./installer.sh
  fi
fi
