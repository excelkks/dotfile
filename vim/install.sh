kernel=`uname -s`
is_mac='N'
release_version='Arch'
package_manager='pacman'
if [[ $kernel = 'Darwin' ]]; then
  is_mac='Y'
  release_version='MacOS'
fi

if [[ $is_mac != 'Y' ]]; then
  release_version=`cat /etc/issue | awk -F' ' '{print $1}'`
fi

# commands
cinstall='pacman -S '
cuinstall='pacman -Rs '

if [[ $release_version = 'MacOS' ]]; then
  tmp=`which brew`
  not_exist_brew=`echo $?`
  if [[ not_exist_brew -eq 1 ]]; then
    echo "please install brew first!!!"
    exit
  fi
  cinstall='brew install '
  cuninstall='brew uninstall '
elif [[ $release_version = 'Ubuntu' ]]; then
  cinstall='apt-get install '
  cuninstall='apt-get purge '
elif [[ $release_version = 'Arch' ]]; then
  echo "Your OS is Archlinux."
else
  echo "sorry, not support your OS..."
  exit
fi

# install packages
# the_silver_searcher

if [[ $release_version = 'MacOS' ]]; then
  $cinstall the_silver_searcher
elif [[ $release_version = 'Ubuntu' ]]; then
  $cinstall silversearcher-ag
elif [[ $release_version = 'Arch' ]]; then
  $cinstall  the_silver_searcher
fi

# copy .vimrc to ~/.vimrc
if [[ -e ~/.vimrc ]]; then
  read -p "exist .vimrc already, exit? Y/N": exist_config
  if [[ $exist_config = 'Y' ]] || [[ $exist_config = 'y']] || [[  $exist_config = 'yes' ]]; then
    exit
  fi
  echo "backing up .vimrc to ~/vimrc.bk ..."
  mv ~/.vimrc ~/vimrc.bk
  cp .vimrc ~/.vimrc
fi

# copy vimspector templates and cocsettings to ~/.vim/
if [[ ! -d ~/.vim ]]; then
  mkdir ~/.vim
fi
echo "copy vimspector templates and cocsettings to ~/.vim/"
cp .vim/coc-settings.json ~/.vim/coc-settings.json
cp .vim/vimspectorTamplate ~/.vim/vimspectorTamplate

if [[ $? -eq 0 ]]; then
  echo "installed success, enjoy it!"
fi
