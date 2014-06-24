"" Plugins
" Load pathogen.vim
execute pathogen#infect()

"" Search
" Jump to matches as a search string is typed
set incsearch
" Highlight search matches
set hlsearch

"" Indentation
" Smart selection of indentation level for new lines
set smartindent
" Filetype-based indentation
filetype plugin indent on

"" Syntax highlighting
" Turn on syntax highlighting
syntax on
" Enable solarized colour scheme (via vim-colors-solarized plugin)
set background=dark
let g:solarized_termtrans=1
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

"" Markdown
" Recognise .md as markdown
au BufNewFile,BufRead *.md set filetype=markdown

"" Perl
" Perl skeleton
au BufNewFile *.pl 0r ~/.vim/perl.skel

"" Misc
" Always show at least two lines of context when scrolling
set scrolloff=2
