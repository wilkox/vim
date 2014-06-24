" Perl skeleton
au BufNewFile *.pl 0r ~/.vim/perl.skel

" Load pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" Jump to matches as a search string is typed
set incsearch

" Highlight search matches
set hlsearch

" Smart selection of indentation level for new lines
set smartindent

" Recognise .md as markdown
au BufNewFile,BufRead *.md set filetype=markdown
