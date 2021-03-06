if ! type git; then
    'NeoBundle: installation aborted.'
fi
if [ ! -e $HOME/.vim ]; then
    mkdir $HOME/.vim
fi
if [ ! -e $HOME/.vim/bundle ]; then
    mkdir $HOME/.vim/bundle
fi
if [ ! -e $HOME/.vim/conf.d ]; then
    ln -rs ./.vim/conf.d $HOME/.vim/conf.d
fi
if [ ! -e $HOME/.vimrc ]; then
    ln -rs ./.vimrc $HOME/.vimrc
fi
git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
