" pathogen plugin management
" execute pathogen#infect('~/.config/nvim/bundle/{}')

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" file and window management
Plugin 'scrooloose/nerdtree'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'moll/vim-bbye'
Plugin 'bling/vim-bufferline'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
" git
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
" Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
" syntax
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'sbdchd/neoformat'
" languages
Plugin 'rust-lang/rust.vim'
Plugin 'tpope/vim-haml'
Plugin 'pangloss/vim-javascript'
Plugin 'tikhomirov/vim-glsl'
Plugin 'flowtype/vim-flow'
Plugin 'mxw/vim-jsx'
Plugin 'HerringtonDarkholme/yats.vim'
"Plugin 'mhartington/nvim-typescript'
"Plugin 'fleischie/vim-styled-components'
Plugin 'tpope/vim-markdown'
Plugin 'groenewege/vim-less'
Plugin 'raichoo/purescript-vim'
" editing
Plugin 'godlygeek/tabular'
Plugin 'ervandew/supertab'
Plugin 'reedes/vim-pencil'
Plugin 'dbmrq/vim-ditto'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" =============
" Basic Options 
" =============
syntax on
set autoindent
set ai
set number
set tabstop=2
set shiftwidth=2
set laststatus=2
set hidden
set mouse=a
" Custom invisibles
set listchars=eol:¬,tab:->,trail:~,extends:>,precedes:<,space:·
set list
set colorcolumn=80
set background=light
set backspace=2
colorscheme typo
" This tells vim how to write the file so that webpack can detect it
set backupcopy=yes
" Conceal-level helps for markdown documents
set conceallevel=3
" Turn on syntax folding
" set foldmethod=syntax
set fillchars=fold:\ 
set clipboard=unnamedplus

" Syntax helper function
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Scrolling
function! SmoothScroll(up)
    if a:up
        let scrollaction="2\<C-y>"
    else
        let scrollaction="2\<C-e>"
    endif
    let counter=0
    while counter<&scroll
        let counter+=2
        exec "normal " . scrollaction
        redraw
        sleep 6m
    endwhile
endfunction

nnoremap <C-U> :call SmoothScroll(1)<Enter>
nnoremap <C-D> :call SmoothScroll(0)<Enter>
inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i

" Insert newline without going into insert mode
nmap <CR> :a<CR><CR>.<CR>

" Specify file types for certain extensions 
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.jess set filetype=javascript
autocmd BufNewFile,BufReadPost *.pegjs set filetype=javascript
autocmd BufNewFile,BufReadPost *.flow set filetype=javascript
autocmd BufNewFile,BufReadPost *.babelrc set filetype=json
autocmd BufNewFile,BufReadPost *.hbs set filetype=mustache
autocmd BufNewFile,BufReadPost *.prettierrc set filetype=yaml

" Prevent bad highlighting in CSS3 properties with dashes
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END

" ========
" NERDTRee
" ========
let NERDTreeIgnore = ['node_modules', '.git$', 'coverage', 'flow-typed']
let g:NERDTreeMinimalUI = 1

" Open NERDTree automatically when vim starts up
autocmd vimenter * NERDTree

" Open NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Toggle NERDTree with CTRL-n 
map <C-n> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

" Git indicators
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "+",
    \ "Untracked" : "++",
    \ "Renamed"   : "->",
    \ "Unmerged"  : "==",
    \ "Deleted"   : "X",
    \ "Dirty"     : "!",
    \ "Clean"     : "√",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" ================
" Highlight better
" ================
hi Todo cterm=bold ctermfg=white ctermbg=red
hi Search ctermbg=green ctermfg=black
hi Visual term=none cterm=none ctermfg=white ctermbg=11
hi ColorColumn ctermbg=black
hi VertSplit ctermbg=black ctermfg=black
hi LineNr ctermbg=black ctermfg=8
hi StatusLine ctermbg=black ctermfg=12 cterm=none
hi Folded ctermbg=black ctermfg=blue
hi StatusLineNC ctermbg=black ctermfg=8 cterm=none
hi SpecialKey ctermfg=8
hi NonText ctermfg=8
hi Comment ctermfg=14
hi NERDTreeFile ctermfg=12
hi NERDTreeDir ctermfg=12
hi NERDTreeDirSlash ctermfg=8

" ====
" BBYE
" ====
nnoremap <Leader>q :Bdelete<CR>

" ==========
" BufferLine
" ==========
let g:bufferline_echo = 0
autocmd VimEnter *
  \ let &statusline='%{bufferline#refresh_status()}'
    \ .bufferline#get_status_string()

" ===
" FZF
" ===
" Configuration for Find command
"
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

map <C-p> :call FZFOpen(':Files')<CR>

" =====================================
" Plain text and markdown configuration
" =====================================
" augroup pencil
 " autocmd!
 " autocmd FileType markdown,mkd call pencil#init({'wrap': 'hard', 'autoformat': 1})
 " autocmd FileType text         call pencil#init()
" augroup END

" Ditto
" au FileType markdown,text DittoOn
nmap <leader>di <Plug>ToogleDitto

" Set the textwidth for pencil enabled files
let g:pencil#textwidth = 80

" Ctrl+K key suspends autoformat for next insert
" nnoremap K <NOP>
let g:pencil#map#suspend_af = 'K'   " default is no mapping
let g:pencil#autoformat_config = {
			\   'markdown': {
			\     'black': [
			\       'htmlH[0-9]',
			\       'markdown(Code|H[0-9]|Url|IdDeclaration|Link|Rule|Highlight[A-Za-z0-9]+)',
			\       'markdown(FencedCodeBlock|InlineCode)',
			\       'mkd(Code|Rule|Delimiter|Link|ListItem|IndentCode)',
			\       'mmdTable[A-Za-z0-9]*',
			\     ],
			\     'white': [
			\      'markdown(Code|Link)',
			\     ],
			\   },
			\ }

" I specified a manual color for indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0

" =============
" NERDCommenter
" =============
" Tell nerdcommenter to insert space after comments
let g:NERDSpaceDelims = 1

" =========
" Syntastic
" =========
autocmd FileType javascript let b:syntastic_skip_checks=1
" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_loc_list = 0 
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
let g:syntastic_rust_rustc_exe = 'cargo check'
let g:syntastic_rust_rustc_fname = ''
let g:syntastic_rust_rustc_args = '--'
let g:syntastic_rust_checkers = ['rustc']
let g:syntastic_javascript_checkers = ['eslint']

" ==========
" Javascript
" ==========
let g:flow#enable = 0
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_markdown = ['prettier']
let g:coverage_json_report_path = 'coverage_jest/coverage-final.json'
autocmd BufWritePre *.js Neoformat
autocmd BufWritePre *.ts Neoformat
autocmd BufWritePre *.md Neoformat

" ====
" Rust
" ====
let g:rustfmt_autosave = 1
let g:rustfmt_command = "rustup run nightly rustfmt"
