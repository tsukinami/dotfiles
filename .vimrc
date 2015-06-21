" {{{ NeoBundle ------------------------
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Markdown'
NeoBundle 'embear/vim-localvimrc'

if filereadable(expand('~/.vimrc.neobundle'))
    source ~/.vimrc.neobundle
endif

call neobundle#end()

filetype plugin indent on

NeoBundleCheck
" ------------------------ NeoBundle }}}

syntax enable

runtime! conf.d/.vimrc.*
runtime ~/.vimrc.local
