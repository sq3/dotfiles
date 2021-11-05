set nocompatible
set nobackup
set noswapfile
set backspace=indent,eol,start
set autoindent ts=4
set textwidth=78
set backupcopy=no
set history=500
set ruler
set encoding=utf-8
set background=light
set number
set cursorline
set mouse=a
set showmatch
set laststatus=2
set wildmenu
set list
set lcs=extends:»
set lcs+=nbsp:·
set lcs+=precedes:«
set lcs+=trail:¬
set lcs+=tab:\|·

call pathogen#infect()
syntax enable
filetype plugin indent on

highlight LineNr ctermfg=black ctermbg=grey

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"colorscheme solarized

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Tabs
set showtabline=2
nmap ö gT
nmap ä gt

" Move tabs
nmap Ä :+tabm<CR>
nmap Ö :-tabm<CR>

let mapleader = ","

" Use Mac OS X Clipboard for Copy/Paste
"nmap <leader>ö :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
vmap <leader>ä :w !xclip<CR>

" Settings, die vom Dateityp abhängen
autocmd FileType python setlocal et sta ts=4 sw=4
autocmd BufNewFile,BufRead *.md  set ft=markdown


if has("autocmd")
    filetype plugin indent on
endif

nmap <Leader><Tab> :set tabstop=4 shiftwidth=4 expandtab<CR>
vnoremap <Leader>c :!sed 's/^/-/' \| column -t \| sed 's/^-//'<CR>
vnoremap <Leader>C :!sed 's/^/-/' \| column -t \| sed 's/^-//'<CR>gv=

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_enable_python_checker = 1

let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'

autocmd Filetype yaml setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=4 sts=4 sw=4

" saltstack syntax "
au BufNewFile,BufRead *.tmpl set ft=jinja
:autocmd FileType yaml set shiftwidth=2
:autocmd FileType yaml set softtabstop=2
:autocmd FileType yaml set autoindent
:autocmd FileType yaml set smartindent
:autocmd FileType yaml set expandtab

au BufRead,BufNewFile *.sls setfiletype yaml
:autocmd FileType yaml set shiftwidth=2
:autocmd FileType yaml set softtabstop=2
:autocmd FileType yaml set autoindent
:autocmd FileType yaml set smartindent
:autocmd FileType yaml set expandtab


nmap <F8> :TagbarToggle<CR>
