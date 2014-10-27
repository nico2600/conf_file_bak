set nocompatible
"activate pathogen
execute pathogen#infect()
call pathogen#helptags()
"set number      "show line numbers
"some stuff to get the mouse going in term
"set mouse=a
"set ttymouse=xterm2
"tell the term has 256 colors
"set t_Co=256

"Create a command :Tidy to invoke perltidy"
"By default it operates on the whole file, but you can give it a"
"range or visual range as well if you know what you're doing."

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
" Highlight search results
set hlsearch
" Enable syntax highlighting
syntax enable
set background=light
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" thanks go
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
   exe "normal mz"
   %s/\s\+$//ge
   exe "normal `z"
   endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.c :call DeleteTrailingWS()
autocmd BufWrite *.pl :call DeleteTrailingWS()

command -range=% -nargs=* Tidy <line1>,<line2>!
    \perltidy -your -preferred -default -options <args>

vmap <tab> >gv    "make tab in v mode indent code"
vmap <s-tab> <gv

nmap <tab> I<tab><esc> "make tab in normal mode indent code"
nmap <s-tab> ^i<bs><esc>

let perl_include_pod   = 1    "include pod.vim syntax file with perl.vim"
let perl_extended_vars = 1    "highlight complex expressions such as @{[$x, $y]}"
let perl_sync_dist     = 250  "use more context for highlighting"

set backspace=2  "Allow backspacing over everything in insert mode"

set autoindent   "Always set auto-indenting on"
set expandtab    "Insert spaces instead of tabs in insert mode. Use spaces for indents"
set tabstop=3    "Number of spaces that a <Tab> in the file counts for"
set shiftwidth=3 "Number of spaces to use for each step of (auto)indent"
set softtabstop=3

set keywordprg=perldoc\ -f
set showmatch    "When a bracket is inserted, briefly jump to the matching one"
map <silent> <F7> "<Esc>:silent setlocal spell! spelllang=en<CR>"
map <silent> <F6> "<Esc>:silent setlocal spell! spelllang=fr<CR>"
map <F2> :Vexplore<CR>
map <F4> :set number!<CR><ESC>

" check perl code with :make
autocmd FileType perl set makeprg=perl\ -c\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m
autocmd FileType perl set autowrite

" paste mode - this will avoid unexpected effects when you
" cut or copy some text from one window and paste it in Vim.
set pastetoggle=<F11>

function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction

hi User1 ctermbg=black  ctermfg=yellow guifg=#ffdad8  guibg=#880c0e
hi User2 ctermbg=black  ctermfg=red    guifg=#000000  guibg=#F4905C
hi User3 ctermbg=black  ctermfg=green  guifg=#292b00  guibg=#f4f597
hi User4 ctermbg=lightred  ctermfg=black  guifg=#112605  guibg=#aefe7B
hi User5 guifg=#051d00  guibg=#7dcc7d
hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
hi User8 guifg=#ffffff  guibg=#5b7fbb
hi User9 guifg=#ffffff  guibg=#810085
hi User0 ctermbg=white    ctermfg=black guifg=#ffffff  guibg=#094afe

set laststatus=2
set statusline=
set statusline+=%7*
set statusline+=\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..) 
set statusline+=%5*\ %{&spelllang}\ \%{HighlightSearch()}\  "Spellanguage & Highlight on?
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.
