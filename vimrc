"" Plugins with vim-plug
" After addding a plugin, run :PlugInstall
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/mileszs/ack.vim.git'
Plug 'https://github.com/jlanzarotta/bufexplorer.git'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/ervandew/supertab.git'
Plug 'https://github.com/tpope/vim-abolish.git'
Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-dispatch.git'
Plug 'https://github.com/easymotion/vim-easymotion.git'
Plug 'https://github.com/kana/vim-fakeclip.git'
Plug 'https://github.com/nathanaelkane/vim-indent-guides.git'
Plug 'https://github.com/xolox/vim-misc.git'
Plug 'https://github.com/xolox/vim-notes.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/christoomey/vim-tmux-navigator.git'
Plug 'https://github.com/mhinz/vim-tmuxify.git'
Plug 'https://github.com/lervag/vimtex.git'
Plug 'https://github.com/FooSoft/vim-argwrap.git'
Plug 'https://github.com/godlygeek/tabular.git'
call plug#end()

"" Indentation
" Set tabstop/shift width to 2 columns, and map this to <Tab>
set tabstop=2 shiftwidth=2 expandtab
" Smart selection of indentation level for new lines
" set smartindent
" Prevent comments from losing indent
inoremap # X#
" Filetype-based indentation
filetype plugin on
filetype indent on
" Highlight indentation levels (via vim-indent-guides plugin)
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

"" Leader
" Map localleader to \
let maplocalleader = "\\"

"" Search
" Jump to matches as a search string is typed
set incsearch
" Highlight search matches
set hlsearch
" Map <Leader>/ (\/) to clearing search highlight
nnoremap <silent> <Leader>/ :nohlsearch<CR>
" Map "//" to search for visually selected text
vnoremap // y/<C-R>"<CR>

"" Syntax highlighting
" Turn on syntax highlighting
set nocompatible
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

"" Shell
" Shell skeleton
au BufNewFile *.sh 0r ~/.vim/shell.skel

"" delimitMate
" Don't match < in .Rmd
au FileType rmd let b:delimitMate_matchpairs = "(:),[:],{:}"
au FileType rmd let b:delimitMate_quotes = "\" '"

"" Tab completion
"" Using supertab plugin
" Enable omnicompletion
set omnifunc=syntaxcomplete#Complete
" Set supertab to use context completion by default
let g:SuperTabDefaultCompletionType = "context"
" Don't scan through included files (takes a very long time)
set complete-=i

"" easymotion
" Require only single leader
map <Leader> <Plug>(easymotion-prefix)
" Bidirectional search
nmap s <Plug>(easymotion-s)

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
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
endif
" Allow backspacing past insertion point
set backspace=indent,eol,start
" jj in insert mode -> ESC
inoremap jj <ESC>
" F5 inserts timestamp as markdown header
nnoremap <F5> "=strftime("## %c")<CR>P
inoremap <F5> <C-R>=strftime("## %c")<CR>
" Show the number of characters/lines highlighted in Visual mode
set showcmd
" Allow project-specific .vimrc
set exrc
set secure
" All folds open on file open
set foldlevel=99

"" Vim-R-plugin
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

"" Persistent undo
call system('mkdir ' . $HOME . "/.vimundo")
set undodir=$HOME/.vimundo
set undofile

"" Spell checking
set spell 
set spelllang=en_au
set spellfile=$HOME/vim/spellfile.add

"" BufExplorer
" Remap BufExplorer invocation
nnoremap <silent> <Leader>qq :BufExplorer<CR>

"" Synchronise unnamed register with clipboard
set clipboard^=unnamed

"" vim-notes
" Set notes directory
let g:notes_directories = ['~/notes']
" Save notes as .md
let g:notes_suffix = '.md'
" Disable indenting on tab keypress, as it overrides omnicompletion
let g:notes_tab_indents = 0

"" vim-argwrap
" Set invocation to <leader>,
nnoremap <silent> <leader>, :ArgWrap<CR>
" Wrap closing brace to newline
let g:argwrap_wrap_closing_brace = 1
