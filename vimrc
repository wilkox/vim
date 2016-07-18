"" Plugins with vim-plug
" After adding a plugin, run :PlugInstall
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/mileszs/ack.vim.git'
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/ervandew/supertab.git'
Plug 'https://github.com/tpope/vim-abolish.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-dispatch.git'
Plug 'https://github.com/easymotion/vim-easymotion.git'
Plug 'https://github.com/kana/vim-fakeclip.git'
Plug 'https://github.com/nathanaelkane/vim-indent-guides.git'
Plug 'https://github.com/xolox/vim-misc.git'
Plug 'https://github.com/wilkox/vim-notes.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/christoomey/vim-tmux-navigator.git'
Plug 'https://github.com/mhinz/vim-tmuxify.git'
Plug 'https://github.com/lervag/vimtex.git'
Plug 'https://github.com/FooSoft/vim-argwrap.git'
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'https://github.com/Shougo/unite.vim'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/Shougo/neoyank.vim'
Plug 'https://github.com/Shougo/neomru.vim'
" Plug 'https://github.com/Valloric/YouCompleteMe.git'
Plug 'https://github.com/mattn/gist-vim.git'
Plug 'https://github.com/mattn/webapi-vim.git'
Plug 'https://github.com/ldong/vim_loremipsum'
Plug 'https://github.com/kana/vim-operator-user'
Plug 'https://github.com/haya14busa/vim-operator-flashy'
Plug 'https://github.com/danro/rename.vim'
Plug 'https://github.com/timakro/vim-searchant'
Plug 'https://github.com/naquad/unite-digraphs'
Plug 'https://github.com/gavinbeatty/dragvisuals.vim'
call plug#end()
" Per-filetype plugins
filetype plugin on

"" Indentation
"" smartindent is the devil! Don't set smartindent!
" Filetype-based indentation
filetype indent on
" Use spaces instead of hard tabs
set expandtab
" Set soft tab to 2 spaces
set softtabstop=2 tabstop=2
set shiftwidth=2 
" Prevent comments from losing indent
inoremap # X#
" Highlight indentation levels (via vim-indent-guides)
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

"" Leader
" Map Leader to comma
let mapleader=","
" Map localleader to backslash
let maplocalleader = "\\"

"" Search
" Jump to matches as a search string is typed
set incsearch
" Highlight search matches
set hlsearch
" Map <Leader>/ (\/) to clearing search highlight
let g:searchant_map_stop = 0 "for vim-searchant
" nnoremap <silent> <Leader>/ <Plug>SearchantStop
nmap <Leader>/ <Plug>SearchantStop
" Map "//" to search for visually selected text
vnoremap // y/<C-R>"<CR>

"" Syntax highlighting
" Turn on syntax highlighting
set nocompatible
syntax on

"" Colourscheme
" Apprentice
colorscheme apprentice

"" Markdown
" Recognise .md as markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown

"" Perl
" Perl skeleton
autocmd BufNewFile *.pl 0r ~/.vim/perl.skel

"" Shell
" Shell skeleton
autocmd BufNewFile *.sh 0r ~/.vim/shell.skel

"" delimitMate
" Don't match < in .Rmd
autocmd FileType rmd let b:delimitMate_matchpairs = "(:),[:],{:}"
autocmd FileType rmd let b:delimitMate_quotes = "\" '"

"" Tab completion
"" Using supertab plugin
" Enable omnicompletion
set omnifunc=syntaxcomplete#Complete
" Set supertab to use context completion by default
let g:SuperTabDefaultCompletionType = "context"
" Don't scan through included files (takes a very long time)
set complete-=i

"" vim-easymotion
nmap <Leader> <Plug>(easymotion-prefix)
" Disable default mappings
let g:EasyMotion_do_mapping = 0
" Minimal keybinding for 'jump anywhere'
nmap s <Plug>(easymotion-s)
" Case-insensitive
let g:EasyMotion_smartcase = 1

"" vim-commentary
" Filetype-specific comment strings
autocmd FileType perl set commentstring=#\ %s
autocmd FileType r set commentstring=#\ %s
autocmd FileType rmd set commentstring=#\ %s

"" Misc
" Always show at least two lines of context when scrolling
set scrolloff=2
" Prevent the frustration of entering Ex mode by accidentally typing Q
nnoremap Q <nop>
" Jump to last position when reopening file
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
endif
" Allow backspacing past insertion point
set backspace=indent,eol,start
" jj in insert mode -> ESC
inoremap jj <ESC>
" Show the number of characters/lines highlighted in Visual mode
set showcmd
" Allow project-specific .vimrc
set exrc
set secure
" All folds open on file open
set foldlevel=99
" Show relative line numbers
set relativenumber
set number
" Text width (for wrapping) = 80
set tw=80
" Single space between sentences when wrapping
set nojoinspaces

"" vim-R-plugin
" Press the space bar to send lines (in Normal mode) and selections to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine
" Vertical split for R pane
let vimrplugin_vsplit = 1
" Disable mapping of "_" to " -> "
let vimrplugin_assign = 0
" Disable matching of <
let vimrplugin_rnowebchunk = 0
" Don't clobber the tmux window title
let vimrplugin_tmux_title = "automatic"
" Don't show R documentation in vim
let vimrplugin_vimpager = "no"
" Mapping to add a magrittr pipe to the end of a line
nnoremap <Leader>p A<space>%>%<esc>

"" Persistent undo
call system('mkdir -p' . $HOME . "/.vimundo")
set undodir=$HOME/.vimundo
set undofile

"" Spell checking
set spell 
set spelllang=en_au
set spellfile=$HOME/vim/spellfile.add

"" Unite
" Mapping to invoke my chosen sources
nnoremap <silent> <Leader>q :Unite -no-split buffer file_mru file digraphs<CR>
" Mapping to invoke the yank history source
let g:unite_source_history_yank_enable = 1
nnoremap <silent> <Leader>y :Unite -no-split history/yank<CR>
" Automatically write buffers before hiding, to prevent nagging reminders
set autowrite

"" Synchronise unnamed register with clipboard
set clipboard^=unnamed

"" vim-notes
" Set notes directory
let g:notes_directories = ['~/notes']
" Save notes as .md
let g:notes_suffix = '.md'
" Disable indenting on tab keypress, as it overrides omnicompletion
let g:notes_tab_indents = 0
" Respect word boundaries
let g:notes_word_boundaries = 1
" Highlight TODOs more obviously
highlight link notesTodo DiffText
" Highlight learning objectives more obviously
highlight notesItalic ctermfg=black ctermbg=darkcyan

"" vim-argwrap
" Set invocation to <Leader>,
nnoremap <silent> <Leader>, :ArgWrap<CR>
" Wrap closing brace to newline
let g:argwrap_wrap_closing_brace = 1

"" Mappings to edit and source .vimrc
nnoremap <Leader>ve :split $MYVIMRC<cr>
nnoremap <Leader>vs :source $MYVIMRC<cr>

"" Mappings to reduce RSI
nnoremap ' :
vnoremap ' :

"" Mappings to run Make
nnoremap <Leader>ml :w <bar> Make -L<cr>
nnoremap <Leader>mnl :w <bar> new <bar> setlocal buftype=nofile <bar> 0read !make -nL<cr>

"" Open splits below and right by default
set splitbelow
set splitright

"" vim-operator-flashy
" Briefly highlights yanked text
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

"" YouCompleteMe
" Blacklisted filetypes
let g:ycm_filetype_blacklist = {'tagbar' : 1, 'qf' : 1, 'unite' : 1, 'text' : 1, 'vimwiki' : 1, 'pandoc' : 1, 'infolog' : 1, 'mail' : 1}

"" Uni study
" Function to generate Anki flashcards from notes
function! MakeAnkiFlashCards ()
  ! anki_from_notes.pl "%:p"
endfunction
nnoremap <Leader>fc :call MakeAnkiFlashCards()<cr>
" Insert timestamp
iab <expr> dts strftime("%F")

"" Show bad characters
" Reveals tabs, non-breaking spaces and trailing whitespace
" From Damien Conway's 'More instantly better vim'
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

"" dragvisuals
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()
