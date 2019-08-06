set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set wrapmargin=0
set autoindent

set modeline

set smartcase           " When searching try to be smart about cases
set hlsearch            " set highlight search on by default
set incsearch           " hightlight search terms as you type

set title               " change terminals title
set wildmenu            " turn on wild menu, meaning :<TAB> will show available options
set wildmode=list:full  " show a list when pressing tab and complete
                        "    first full match
set wildignore=*.swp,*.bak,*.pyc,*.class

set ttyfast             " always use a fast terminal
set cursorline          " underline the current line, for quick orientation
set ruler               " always use current position"
set number              " set line numbers by default
set hidden              " allow you to open new file without having to save current file first
set noswapfile          " do not have swap file
set foldenable          " enable folding
set autoread            " automatically reload files changed outside of Vim

set laststatus=2        " Always show the status line

"Manual setting of status line
"set statusline+=%t%r\ %y[%{&ff},%{strlen(&fenc)?&fenc:'none'}]\ %{FileSize()}\ %m%=%P\ Lines:%l/%L

"Allow buffers to automatically be displayed when only one tab open
let g:airline#extensions#tabline#enabled = 1

"Seperator for buffers set to space
let g:airline#extensions#tabline#left_sep = ' '
let g:airline_left_sep = '▶'

"Know the type of file"
filetype indent plugin on

"have syntax highlighting enabled
syntax on

"allow installation of vim plugins in ~/.vim/bundle
execute pathogen#infect()

"display what file is open in title
let &titleold=getcwd()

"set leader to ,
let mapleader=","

"show any whitespace
match ErrorMsg '\s\+$'

"Jedi key re-mappings
"let g:jedi#usages_command = '<Leader>u'
"let g:jedi#goto_assignments_command = '<Leader>a'

"using ,rw will delete all whitespace within file
nnoremap <Leader>rw :%s/\s\+$//e<CR>

"using ,cs will remove the last search term to stop highlighting
nnoremap <Leader>cs :let @/ = ""<CR>

" Toggle line numbers
nnoremap <Leader>sn :setlocal number!<CR>

" Toggle relative numbers
nnoremap <Leader>sr :set relativenumber!<cr>

" Toggle colorcolmun numbers
nnoremap <Leader>sc :set colorcolumn=80<cr>

" Toggle colorcolmun numbers
nnoremap <Leader>dc :set colorcolumn=0<cr>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

"
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
"colorscheme eva

"this funciton will highlight the status bar to a different color when in
""insertion mode
function! InsertStatuslineColor(mode)
    if a:mode == 'i'
        hi statusline guibg=Purple ctermfg=5 guifg=Yellow ctermbg=3
    endif
endfunction

"Setting statusline colors
"au InsertEnter *.* call InsertStatuslineColor(v:insertmode)
"au InsertLeave *.* hi statusline ctermbg=LightCyan ctermfg=Black
"
hi ErrorMsg ctermbg=DarkRed guibg=DarkRed
"
"hi StatusLine ctermbg=lightCyan ctermfg=black
"
"hi Search cterm=NONE ctermfg=blue ctermbg=white

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
