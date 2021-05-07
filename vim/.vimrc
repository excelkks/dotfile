" require
" 1. the silver searcher (for fzf: Ag)
"
"
" ===
" === auto load plug 
" ===
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC 
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
"                  Editor Setup                  "
""""""""""""""""""""""""""""""""""""""""""""""""""


" ====================
" === Editor Setup ===
" ====================
" ===
" === Editor behavior
" ===
"
set number
set relativenumber
set cursorline
set shiftwidth=2         " set tab width
set expandtab            " convert tab to space
                         " :retab! can convert exist tab to spaces
set tabstop=2            " show tab as 4 space, but dont change files
set softtabstop=2        " treat 4 space as tab(e.g. BS will delete 4 space)
set autoindent
set cindent
set scrolloff=4
set notimeout
set autochdir
set wrap
set textwidth=0
set formatoptions-=tc
set splitright
set splitbelow
set hlsearch
set showcmd
set wildmenu
set ignorecase
set smartcase
set ttyfast
set lazyredraw
set novisualbell
set laststatus=2
set encoding=UTF-8
silent !mkdir -p ~/.vim/tmp/backup
silent !mkdir -p ~/.vim/tmp/undo
set backupdir=~/.vim/tmp/backup,.
set directory=~/.vimr/tmp/undo,.
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/tmp/undo,.
endif
set virtualedit=block
set mouse=a

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ===
" === Basic Mapping 
" ===

nnoremap ff <Esc><Esc>
vnoremap ff <Esc><Esc>
inoremap ff <Esc><Esc>
cnoremap ff <Esc><Esc>

let mapleader="\<Space>"

noremap <Leader>rc :e ~/.vimrc<CR>
" noremap <Leader><CR> :nohlsearch<CR>
vnoremap <Leader><CR> <Esc><Esc>

" split
noremap sl :set splitright<CR>:vsp<space>
noremap sh :set nosplitright<CR>:vsp<space>
noremap sj :set splitbelow<CR>:split<space>
noremap sk :set nosplitbelow<CR>:split<space>

"resize
noremap <Up> :res +1<CR>
noremap <Down> :res -1<CR>
noremap <Left> :vertical res -1<CR>
noremap <right> :vertical res +1<CR>

" cursor movement at command mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <right>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" cnoremap <M-b> <S-Left>
" cnoremap <M-f> <S-Right>

" window focus
noremap gh <C-w>h
noremap gl <C-w>l
noremap gj <C-w>j
noremap gk <C-w>k

" tab
noremap <Leader>tn :tabNext<CR>
noremap <Leader>tp :tabprevious<CR>

noremap <Leader>s :%s///g<Left><Left><Left>

syntax on
filetype plugin indent on
set signcolumn=yes

" Compile function
noremap <f2> :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    set splitbelow
    exec "!gcc % -o %<"
    :term ./%<
    :res -15
  elseif &filetype == 'cpp'
    set splitbelow
    exec "!g++ -std=c++11 % -Wall -o %<"
    :term ./%<
    :res -15
  elseif &filetype == 'sh'
    set splitbelow
    :term bash %
    :res -15
  elseif &filetype == 'python'
    set splitbelow
    :term python3 %
    :res -15
  elseif &filetype == "markdown"
    exec "MarkdownPreview"
  endif
endfunc


""""""""""""""""""""""""""""""""""""""""""""""""""
"                    Plugins                     "
""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'excelkks/vim-snippets'

" highlight
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
" Plug 'RRethy/vim-illuminate'

Plug 'liuchengxu/eleline.vim'

" debug
Plug 'puremourning/vimspector'

Plug 'airblade/vim-rooter'

Plug 'ajmwagar/vim-deus'

" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for': ['markdown', 'vim-plug']}
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }

" git
Plug 'airblade/vim-gitgutter'

" json
Plug 'kevinoid/vim-jsonc'

Plug 'tpope/vim-surround'          " ys, cs, ds

Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-after-object'  " da= to delete what's after =
Plug 'godlygeek/tabular'          " Tabularize <regex> to align
Plug 'tpope/vim-speeddating'

Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

Plug 'pechorin/any-jump.vim'     " <Leader>j <Leader>ab <Leader>al
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" ===
" === neoclide/coc.nvim
" ===

let g:coc_global_extensions = [
            \ 'coc-clangd',
            \ 'coc-cmake',
            \ 'coc-pyright',
            \ 'coc-json',
            \ 'coc-sh',
            \ 'coc-git',
            \ 'coc-css',
            \ 'coc-html',
            \ 'coc-snippets']
" Set internal encoding of Vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapping
" other plugin begore putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() 
            \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Generate compile_command.json
command! -nargs=0 GenerateCompileCommands :echo "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=debug ../.."


" ===
" === puremourning/vimspector
" ===
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets = ['debugpy', 'vscode-cpptools']

func Splittotab()
  :tabnew %
  :tabprevious
  :q
  :tabn
endfunc
nnoremap <Leader>tb :call Splittotab()<CR>
" for normal mode - the word under the cursor
nmap <Leader><CR> <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader><CR> <Plug>VimspectorBalloonEval
func! CopyVimspectorTamplate()
    let ol ='Y'
    if !empty(glob('.vimspector.json'))
        let ol = input('Existing .vimspector.json file, overloap it? Y/N ', 'N')
    endif
        if ol == 'Y'
            if &filetype == 'c' || &filetype == 'cpp'
                silent !cp ~/.vim/vimspectorTamplate/cpp/.vimspector.json ./
            elseif &filetype == 'python'
                silent !cp ~/.vim/vimspectorTamplate/python/.vimspector.json ./
            endif
        endif
    :e .vimspector.json
endfunc
command! -nargs=0 LoadVimspectorTample :call CopyVimspectorTamplate()

" ===
" === 'RRethy/vim-hexokinase'
" ===
set termguicolors
let g:Hexokinase_highlighters = ['backgroundfull']

" ===
" === airblade/vim-rooter
" ===
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = ['Rakefile', '.root', '.svn', '.project', '.git/']
autocmd BufEnter * :Rooter

" ===
" === ajmwagar/vim-deus
" ===
set t_Co=256

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark    " Setting dark mode
colorscheme deus
let g:deus_termcolors=256

" ===
" === iamcco/markdown-preview.nvim
" ===
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 1

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 1

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = '9999'

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" ===
" === junegunn/vim-after-object
" ===
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ', '/', '\')

" ===
" === godlygeek/tabular
" ===
vmap ga :Tabularize /

" ===
" === scrooloose/nerdtree
" ===
noremap <Leader>n :NERDTreeToggle<CR>

" ===
" === 'junegunn/fzf.vim'
" ===
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'relative': v:true, 'yoffset': 1.0 } }

" ===
" === Plug 'junegunn/fzf.vim'
" ===

noremap <Leader>b :Buffer<CR>


