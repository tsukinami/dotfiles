set enc=utf-8
set fenc=utf-8
set fencs=utf-8,iso-2022-jp,euc-jp,cp932
set ffs=unix,dos,mac " LF, CRLF, CR
set expandtab
set tabstop=4
set shiftwidth=4
set cindent
set smartindent
set smarttab
set showmatch
set hlsearch
set laststatus=2
set showcmd
set showmode
set number
set scrolloff=999
set background=dark
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set helplang=ja
set t_Co=256
set backspace+=indent,eol,start
set whichwrap=b,s,h,s,<,>,[,] " カーソルを行頭、行末で止まらないようにする
set wildmenu " コマンド補完を強化
set wildmode=list:full " リスト表示，最長マッチ

" UTF-8の□や○でカーソル位置がずれないようにする
if exists('&ambiwidth')
    set ambiwidth=double
endif

" Esc連打で検索ハイライトを消す
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Escの代わりにjj
inoremap jj <Esc>

" カレントウィンドウにのみ罫線を引く
set cursorline
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END

" md as markdown, instead of modula2
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

" for tmux
autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* set filetype=tmux

" 個別の色設定
autocmd ColorScheme * highlight Normal cterm=NONE ctermfg=NONE ctermbg=NONE
autocmd ColorScheme * highlight Delimiter ctermfg=NONE
autocmd ColorScheme * highlight LineNr cterm=NONE ctermfg=NONE ctermbg=NONE
autocmd ColorScheme * highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
autocmd ColorScheme * highlight CursorLineNr cterm=underline ctermfg=208 ctermbg=NONE
autocmd ColorScheme * highlight MatchParen term=reverse cterm=bold ctermfg=81 ctermbg=233
autocmd ColorScheme * highlight Pmenu ctermbg=24 ctermfg=NONE
autocmd ColorScheme * highlight PmenuSel ctermbg=white ctermfg=24
autocmd ColorScheme * highlight PMenuSbar ctermbg=24 ctermfg=NONE
autocmd ColorScheme * highlight SpecialKey cterm=NONE ctermfg=236
autocmd ColorScheme * highlight NonText cterm=NONE ctermfg=236
autocmd ColorScheme * highlight SignColumn ctermbg=NONE

function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=236 gui=reverse guifg=236
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

" NeoBundle
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle'
call neobundle#end()

"let g:neobundle#types#git#default_protocol = 'https'
"NeoBundle 'Shougo/neocomplete'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/vimproc.vim', {
"      \ 'build' : {
"      \     'windows' : 'make -f make_mingw32.mak',
"      \     'cygwin' : 'make -f make_cygwin.mak',
"      \     'mac' : 'make -f make_mac.mak',
"      \     'unix' : 'make -f make_unix.mak',
"      \    },
"      \ }
"NeoBundle 'Shougo/vimshell.vim'
"NeoBundle 'Shougo/vimfiler.vim'
"NeoBundle 'Shougo/unite-outline'
"NeoBundle 'Shougo/neosnippet'
NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'gregsexton/gitv'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'tomasr/molokai'
"NeoBundle 'Markdown'
NeoBundle 'embear/vim-localvimrc'
"NeoBundle 'violetyk/neocomplete-php.vim'
"NeoBundle 'honza/vim-snippets'

filetype on
filetype plugin indent on   " Required!

syntax enable
let g:molokai_original = 1
let g:rehash256 = 1
"let loaded_matchparen = 1

" vim-localvimrc 設定を確認なしで読み込む
let g:localvimrc_ask = 0

let g:netrw_liststyle=3

colorscheme molokai

NeoBundleCheck

autocmd FileType * set formatoptions=lmoq

"--------------------------------------
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

"--------------------------------------
" lightline.vim
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'
let g:gitgutter_sign_modified_removed = '➜✘'

let g:lightline = {
        \ 'colorscheme': 'solarized_dark',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [
        \     ['mode', 'paste'],
        \     ['cwd', 'fugitive', 'gitgutter'],
        \     ['filename'],
        \   ],
        \   'right': [
        \     ['lineinfo', 'syntastic'],
        \     ['percent'],
        \     ['charcode', 'fileformat', 'fileencoding', 'filetype'],
        \   ]
        \ },
        \ 'component': {
        \   'cwd': '%{fnamemodify(getcwd(), ":~")}'
        \ },
        \ 'component_expand': {
        \   'syntastic': 'SyntasticStatuslineFlag'
        \ },
        \ 'component_type': {
        \   'syntastic': 'error'
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode',
        \   'charcode': 'MyCharCode',
        \   'gitgutter': 'MyGitGutter',
        \ },
        \ 'separator': {'left': '', 'right': ''},
        \ 'subseparator': {'left': '', 'right': ''}
        \ }

let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_enable_highlighting = 1
let g:syntastic_php_php_args = '-l'

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.php,*.pl,*.pm call s:syntastic()
augroup END

function! s:syntastic()
  SyntasticCheck
  call lightline#update()
  Errors
endfunction

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '[RO]' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' != expand('%:f') ? expand('%:f') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '['._.']' : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? 'ff:'.&fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? 'ft:'.(strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? 'fenc:'.(strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

function! MyCharCode()
    redir => ascii
    silent! ascii
    redir END

    if match(ascii, 'NUL') != -1
        return 'NUL'
    endif

    let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

    " Unicodeスカラ値
    let uniHex = printf('%X', nr)
    if strlen(uniHex) < 4
        for i in range(4 - strlen(uniHex))
            let uniHex = '0' . uniHex
        endfor
    endif
    let uniHex = 'U+' . uniHex

    " iconvが利用可能ならfileencodingでの文字コードも表示する
    if has('iconv') && has('multi_byte')
        let fencStr = iconv(char, &encoding, &fileencoding)
        let fencHex = ''
        for i in range(strlen(fencStr))
            let fencHex = fencHex . printf('%X', char2nr(fencStr[i]))
        endfor
        let fencHex = '0x' . (strlen(fencHex) % 2 == 1 ? '0' : '') . fencHex

        return "'" . char . "' " . fencHex . " (" . uniHex . ")"
    else
        return "'" . char . "' " . uniHex
    endif
endfunction
