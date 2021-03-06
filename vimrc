"" Plugins with vim-plug
" After adding a plugin, run :PlugInstall
call plug#begin('~/.vim/plugged')
Plug 'ervandew/supertab'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'vim-pandoc/vim-rmarkdown'
Plug 'yuttie/comfortable-motion.vim'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'FooSoft/vim-argwrap'
Plug 'godlygeek/tabular'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'
Plug 'danro/rename.vim'
Plug 'timakro/vim-searchant'
Plug 'naquad/unite-digraphs'
Plug 'justinmk/vim-sneak'
Plug 'jalvesaq/Nvim-R'
Plug 'tpope/vim-speeddating'
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
" Reflow paragraphs with Q
noremap Q gqap

"" Nvim-R
" Press the space bar to send lines (in Normal mode) and selections to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine
" Vertical split for R pane
let R_tmux_split = 1
let R_min_editor_width = 70
" Disable mapping of "_" to " -> "
let R_assign = 0
" Disable matching of <
let R_rnowebchunk = 0
" Don't clobber the tmux window title
let R_tmux_title = "automatic"
" Don't show R documentation in vim
let R_nvimpager = "no"
" Use my own tmux config
let R_notmuxcong = 1
" R-friendly abbreviations
iab >> %>%
iab << <-

"" Persistent undo
call system('mkdir -p' . $HOME . "/.vimundo")
set undodir=$HOME/.vimundo
set undofile

"" Spell checking
set spell 
set spelllang=en_au
set spellfile=$HOME/vim/spellfile.add
" Don't highlight capitalisation
set spellcapcheck=
nnoremap zl 1z=

"" unite
" Mapping to invoke my chosen sources and invoke insert mode
nnoremap <silent> <Leader>q :Unite -no-split buffer file_mru file digraphs<CR>
" Mapping to invoke the yank history source
let g:unite_source_history_yank_enable = 1
nnoremap <silent> <Leader>y :Unite -no-split history/yank<CR>
" Automatically write buffers before hiding, to prevent nagging reminders
set autowrite

"" vim-notes
" Set notes directory
let g:notes_directories = ['~/notes']
" Disable indenting on tab keypress, as it overrides omnicompletion
let g:notes_tab_indents = 0
" Respect word boundaries
let g:notes_word_boundaries = 1
" Overwrite replacement of dashed lists with Unicode bullets
" There is an option for this but it doesn't work
" TODO submit this as a pull request at some point
function! xolox#notes#get_bullet(chr)
  return '-'
endfunction
" Highlight TODOs more obviously
highlight link notesTodo DiffText
" Highlight learning objectives
highlight notesAtxHeading ctermfg=black ctermbg=darkcyan
" TODO italics
highlight notesItalic ctermfg=black ctermbg=darkcyan
" Don't highlight quoted text
highlight link notesSingleQuoted normal
highlight link notesDoubleQuoted normal
" Soft wraps in notes
autocmd FileType notes set wrap linebreak nolist textwidth=0 wrapmargin=0

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

"" Splits
" Open splits below and right by default
set splitbelow
set splitright
" Always open help files in a rightward vertical split
" autocmd FileType help,* wincmd L

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
" Run 'clean learning objectives' in visual mode
vnoremap <Leader>clo :'<,'>! clean_learning_objectives.pl<cr>

"" Show bad characters
" Reveals tabs, non-breaking spaces and trailing whitespace
" From Damien Conway's 'More instantly better vim'
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

"" link_slides
source ~/vim/scripts/link_slides.vim
nnoremap <Leader>ls :call link_slides#link_slides()<cr>
nnoremap <Leader>os :call link_slides#open_slides()<cr>

"" Synchronise unnamed register with clipboard
set clipboard^=unnamed

"" vim-pandoc
"" NOTE TO SELF: for making with default arguments, see :PandocTemplate (my
"" template is saved as #make)
" Enabled and disabled modules
" let g:pandoc#modules#enabled = []
" let g:pandoc#modules#disabled = ["folding"]
" Autoformat with hard breaks
" let g:pandoc#formatting#mode = "hA"
let g:pandoc#formatting#mode = "h"
" let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1
" Allow folding of YAML front matter
let g:pandoc#folding#fold_yaml = 1
" Styles not to use conceal with for vim-pandoc-syntax
let g:pandoc#syntax#conceal#blacklist = ["subscript", "superscript"]
