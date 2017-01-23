set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set wrapmargin=0
set autoindent

set modeline

set smartcase       " When searching try to be smart about cases
set hlsearch        " set highlight search on by default
set incsearch       " hightlight search terms as you type

set title           " change terminals title
set wildmenu        " turn on wild menu, meaning :<TAB> will show available options
set ruler           " always use current position"
set number          " set line numbers by default
set hidden          " allow you to open new file without having to save current file first
set noswapfile      " do not have swap file
set foldenable      " enable folding

set laststatus=2    " Always show the status line
set statusline+=%t%r\ %y[%{&ff},%{strlen(&fenc)?&fenc:'none'}]\ %{FileSize()}\ %m%=%P\ Lines:%l/%L

"Know the type of file"
filetype indent plugin on

"have syntax highlighting enabled"
syntax on

"display what file is open in title"
let &titleold=getcwd()

"set leader to ,"
let mapleader=","

"show any whitespace"
match ErrorMsg '\s\+$'

"using ,rw will delete all whitespace within file"
nnoremap <Leader>rw :%s/\s\+$//e<CR>

"using ,cs will remove the last search term to stop highlighting"
nnoremap <Leader>cs :let @/ = ""<CR>

"disable arrow keys in Escape mode :)
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>
"
""disable arrow keys in Insert mode :)
"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>

"do folds yourself by zf
"set foldmethod=manual

"setting colorscheme to eflord which is in /usr/share/vim/vim70/colors
colorscheme eva01

"this funciton will highlight the status bar to a different color when in
""insertion mode
function! InsertStatuslineColor(mode)
    if a:mode == 'i'
        hi statusline guibg=Purple ctermfg=5 guifg=Yellow ctermbg=3
    endif
endfunction

au InsertEnter *.* call InsertStatuslineColor(v:insertmode)
au InsertLeave *.* hi statusline ctermbg=LightCyan ctermfg=Black

hi ErrorMsg ctermbg=DarkRed guibg=DarkRed

hi StatusLine ctermbg=lightCyan ctermfg=black

hi Search cterm=NONE ctermfg=blue ctermbg=white

"function to get the size of the file
function! FileSize()
let bytes = getfsize(expand("%:p"))
if bytes <= 0
    return ""
endif
if bytes < 1024
    return bytes
else
    return (bytes / 1024) . "K"
endif
endfunction
