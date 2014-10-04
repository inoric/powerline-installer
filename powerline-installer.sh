#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

apt-get update
apt-get -y install python-pip git vim
pip install git+git://github.com/Lokaltog/powerline
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo fc-cache -vf
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/


# Bind powerline to vim, set 256-color mode.
echo -e "
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256
" >> /etc/vim/vimrc

# Bind powerline to bash.
echo -e "
if [ -f /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh ]; then
    source /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
fi" >> /etc/bash.bashrc

# Remove directory depth limit in powerline shell.
sudo sed -i 's/\("dir_limit_depth":\).*/\1 null/' /usr/local/lib/python2.7/dist-packages/powerline/config_files/themes/shell/__main__.json
