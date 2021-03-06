" No vi comptiblilty (I think) /Arash
set nocompatible

" Map leader key
let mapleader = " "

" NeoBundle
source ~/.vim/plugin-configs/neobundle.vim

" Tags
set tags=./tags;/

" Taken from vimcast 'bubbling text'
" Visually select the text that was last edited/pasted
nmap gV `[v`]

" Turn on line numbering. Turn it off with "set nonu"
set nu

" Indent automatically depending on filetype
filetype indent on
set autoindent

" Higlhight search
set hlsearch

set incsearch     " show search matches as you type

" Wrap text instead of being on one line
set linebreak

" Set solarized (from `:help solarized`)
syntax enable
set background=dark
colorscheme solarized
set t_Co=16 " <https://github.com/sigurdga/gnome-terminal-colors-solarized>

" Use syntax highlighting
syntax on

set smartindent
set expandtab

" Folding -- Start everything unfolded please
" Note, perl automatically sets foldmethod in the syntax file
" autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
" autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR
set foldlevelstart=20

" Show trailing whitepace and spaces before a tab:
" highlight ExtraWhitespace ctermbg=red guibg=red
" autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

" Insert Paste
set pastetoggle=<F2>

" Remove trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Hidden means that buffers undo history are still in history when you switch
" between them http://stackoverflow.com/a/2732336/621449
set hidden

" hjkl mappings
" Estimate of the old shortcuts I had for Lusty etc.
noremap k :CtrlPBuffer<CR>
noremap l :CtrlP<CR>
" noremap k :Unite -start-insert buffer<CR>
" noremap l :Unite -start-insert file_rec/async<CR>
noremap gl :VimFiler<CR>
noremap gL :VimFilerCurrentDir<CR>
let g:unite_source_history_yank_enable = 1
nnoremap h :<C-u>Unite history/yank<CR>

set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.hi,*.bc,*.png,*.gif,*.pdf,_site,_cache,target

" Wildmenu
set wildmenu

" Sourcings
source ~/.vim/plugin-configs.vim " Source all plugin requirement options

" No delayed "ESC"
set timeoutlen=1000 ttimeoutlen=0

" Use par as formatprg
" (http://vimcasts.org/episodes/formatting-text-with-par/)
set formatprg=par

" https://app.asana.com/0/2677909504410/10631479299225
" Basically, <Leader>p is same as paste from clipboard
noremap <Leader>p "+p
noremap <Leader>P "+P
noremap <Leader>y "+y
noremap <Leader>Y "+Y

" Create <leader>gf binding, like gf but creating file if it doesn't exist.
" 
" https://app.asana.com/0/2677909504410/8354666017829
" http://superuser.com/questions/277325/create-a-file-under-the-cursor-in-vim
map <leader>gf :e <cfile><cr>
vmap <leader>gf "ay:e <C-r>a<cr>

" Make backspace work again.
" When I removed NeoComplCache, backspace stopped working for some reason
"
" http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=indent,eol,start

" http://stackoverflow.com/a/4255960
"
" Keep window position when switching between buffers.
"
" I never saw any breakage after adding this but I didn't notice that much
" problems with this before adding this either.
if v:version >= 700
  au BufLeave * let b:winview = winsaveview()
  au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif

" http://stackoverflow.com/a/8292950
"
" Keep cursor column when switching between buffers.
set nostartofline

" Python completeing started hanging on dot,
" http://stackoverflow.com/a/21769051/621449
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_completion = 0

" In combination with tmux, vim behaves weirdly on <Ctrl>+ArrowLeft
" http://superuser.com/a/402084/97600
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Make hsc files to Haskell files (like ExecutionStack.hsc)
au BufRead,BufNewFile *.hsc set filetype=haskell

" Prefer vertical diff over horizontal
"
" I noticed this due to that `:Gd` started to do horizontal diffs which are
" useless. One could do `:Gvdiff` to make the diff vertical, but I don't yet
" understand why one would ever want horizontal diffs.
"
" https://github.com/tpope/vim-fugitive/issues/523
set diffopt+=vertical
