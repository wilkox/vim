" Perl skeleton
au BufNewFile *.pl 0r ~/.vim/perl.skel

" Load pathogen.vim
call pathogen#infect()
call pathogen#helptags()
