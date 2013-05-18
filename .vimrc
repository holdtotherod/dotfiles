map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
set wmh=0
set nohlsearch
"set background=dark
set tabstop=4
set number
set bs=2
set wrap!
set shiftwidth=4
set incsearch
set ignorecase
set smartcase

"set clor scheme
syntax enable

set scrolloff=10
"make vim save and load the folding of the document each time it loads"
"also places the cursor in the last place that it was left."
au BufWinLeave * mkview
au BufWinEnter * silent loadview

"if has("mouse")
"    set mouse=a
"endif
