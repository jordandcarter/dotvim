colorscheme vividchalk
set guifont=Monaco:h10

" --------------- 
" Persistent Undo 
" --------------- 
set undofile                " Save undo's after file closes 
set undodir=$HOME/.vim/undo " where to save undo histories 
set undolevels=1000         " How many undos 
set undoreload=10000        " number of lines to save for undo" 


" Unbind these keys for different bindings in vimrc
if has('gui_macvim')
  " D-t
  macmenu &File.New\ Tab key=<nop>
  " D-p
  macmenu &File.Print key=<nop>

  " D-p
  macmenu Edit.Find.Find\.\.\. key=<nop>

  " D-b
  macmenu &Tools.Make key=<nop>
  " D-l
  macmenu &Tools.List\ Errors key=<nop>
endif
