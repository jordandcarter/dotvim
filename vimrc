call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax on

if has("autocmd")
  filetype plugin indent on
endif

set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab
set grepprg=ack

"Keymappings
let mapleader = ","
:nmap <unique> <silent> <Leader>t :CommandT<CR>
:nmap <unique> <silent> <Leader>b :CommandTBuffer<CR>
:map gc :Rcontroller<CR>
:map gm :Rmodel<CR>
:map gv :Rview<CR>
:map gl :Rlayout<CR>
:map gs :Rspec<CR>
:map gw :Rfind<Space>
:map gec :Rcontroller<Space>
:map gem :Rmodel<Space>
:map gev :Rview<Space>
:map gel :Rlayout<Space>
:map ges :Rspec<Space>
:nmap H 0
:nmap L $

:map cn :cnext<CR>
:map cp :nprev<CR>

" map ,cd to change to current files directory
map ,cd :cd %:p:h<CR>:pwd<CR>

" auto reading/writing
set autoread " auto read externally modified files
set autowrite " write when leaving buffer
set autowriteall " write when leaving buffer (always)
set nobackup " no backup files
set noswapfile " don't liter .swp files everywhere please
set number
autocmd FocusLost * :wa " write on loss of focus (gvim)
autocmd BufLeave,FocusLost * silent! wall

" arrow keys to change window
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
let g:CommandTCancelMap='<C-x>'

" map ctrl-s to save :NOTE set the following in bashrc> stty stop ^- #use 'ctrl -' to replace 'ctrl s'
noremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>


" http://items.sjbach.com/319/configuring-vim-right
" The current buffer can be put to the background without writing to disk;
" When a background buffer becomes current again, marks and undo-history are remembered.
" Turn this on.
set hidden

nnoremap ' `
nnoremap ` '

set history=1000

" tab completion in command mode
set wildmode=list:longest

" searching
set ignorecase
set smartcase

" whats this do? : set title

" scrolling
set scrolloff=3

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

set ruler

" Intuitive backspacing in insert mode
set backspace=indent,eol,start


" Highlight search terms...
set hlsearch
set incsearch " ...dynamically as they are typed.
" If the search term highlighting gets annoying, set a key to switch it off
" temporarily:
nmap <silent> <leader>n :silent :nohlsearch<CR>
"set statusline+=%{rvm#statusline()}
"set statusline+=%{fugitive#statusline()}

let g:rubytest_cmd_test = "testdrb -Itest %p"
let g:rubytest_cmd_testcase = "testdrb -Itest %p -n '/%c/'"

" Insert mode status line color
" first, enable status line always
set laststatus=2

" now set it up to change the status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif

" run a shell command and have its output in a new&unsaved buffer
function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize ' . line('$')
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
command! -complete=file -nargs=* Git call s:ExecuteInShell('git '.<q-args>)
command! -complete=file -nargs=* Bzr call s:ExecuteInShell('bzr '.<q-args>)

" quickly open current file into a tab, then close it
nmap t% :tabedit %<CR>
nmap td :tabclose<CR>

" NERD tree toggle open and closed
:map <F2> :NERDTreeToggle<CR>

if has("persistent_undo")
  set undodir=~/.vim/undodir
  set undofile
endif
"let g:rubytest_in_quickfix = 1

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']                                                                                                                                                         
map <Leader>n :NERDTreeToggle<CR>

" Command-T configuration
let g:CommandTMaxHeight=20

func GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)
