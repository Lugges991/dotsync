if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'nvie/vim-flake8'
Plug 'scrooloose/nerdtree'
Plug 'lervag/vimtex'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vifm/neovim-vifm'
"Plug 'Valloric/YouCompleteMe'
Plug 'dylanaraps/wal.vim'
Plug 'tell-k/vim-autopep8'
Plug 'https://github.com/chrisbra/csv.vim'
Plug 'ryanoasis/vim-devicons'
"Plug 'rust-lang/rust.vim', { 'for': 'rust' }
"Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'vimlab/split-term.vim'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
"Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

syntax enable
colorscheme dracula
nmap <C-n> :NERDTree<cr>


""""""""""""""""""""""""""""""""""""""""""""
" CoC                                      "
""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set hidden


" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `ög` and `äg` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> ög <Plug>(coc-diagnostic-prev)
nmap <silent> äg <Plug>(coc-diagnostic-next)

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
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

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
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


""""""""""""""""""""""""""""""""""""""""""""
" END OF CoC                                      "
""""""""""""""""""""""""""""""""""""""""""""


set relativenumber

" more natural splitting
set splitbelow
set splitright

" autostarts NERDTree
" au vimenter * :10Term 
" au vimenter * NERDTree
" au vimenter * :winc l
set nu

" always open NERDTree on the right
let g:NERDTreeWinPos = "right"

" fuzzy finding
let $FZF_DEFAULT_COMMAND = "find . -type f -not -path '*/\.git/*' "

let g:airline_powerline_fonts = 1
set t_Co=256
set scrolloff=15

" set vimtex pdf viewer
let g:tex_flavor = "latex"
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_general_viewer = 'zathura'

" YouCompleteMe options
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_autoclose_preview_window_after_completion=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Set to auto read when a file is changed from the outside
set autoread

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

set ruler
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" activate wildmenu
set wildmenu

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


let t:is_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        let t:is_tranparent = 0
    endif
endfunction


""""""""""""""""""""""""""""""
"  ____  _   _  ___  ____ _____ ____ _   _ _____ ____  
" / ___|| | | |/ _ \|  _ \_   _/ ___| | | |_   _/ ___| 
" \___ \| |_| | | | | |_) || || |   | | | | | | \___ \ 
"  ___) |  _  | |_| |  _ < | || |___| |_| | | |  ___) |
" |____/|_| |_|\___/|_| \_\|_| \____|\___/  |_| |____/ 
"                                                      
""""""""""""""""""""""""""""""

" Define local leader
let maplocalleader = "-"

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

"fast tab switching
nmap <leader>n :tabn<cr>
nmap <leader>j :tabp<cr>

nmap <leader>t :10Term<cr>

" Fast saving
nmap <leader>w :w!<cr>
" fast quit
nmap <leader>q :wqa<cr>
" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null


" Tab completion
imap <Tab> <C-P>
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

nnoremap <leader>r <C-w>=

map <space> /
map <c-space> :FZF <cr>


" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Switching between buffers
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" word count
:xnoremap <leader>c <esc>:'<,'>:w !wc -w<CR>


""""""""""""""""""""""""""""""
"  ____ _____  _  _____ _   _ ____    _     ___ _   _ _____ 
" / ___|_   _|/ \|_   _| | | / ___|  | |   |_ _| \ | | ____|
" \___ \ | | / _ \ | | | | | \___ \  | |    | ||  \| |  _|  
"  ___) || |/ ___ \| | | |_| |___) | | |___ | || |\  | |___ 
" |____/ |_/_/   \_\_|  \___/|____/  |_____|___|_| \_|_____|
"                                                           
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

""""""""""""""""""""""""""""""
"   ____ _     ___ ____  ____   ___    _    ____  ____  
"  / ___| |   |_ _|  _ \| __ ) / _ \  / \  |  _ \|  _ \ 
" | |   | |    | || |_) |  _ \| | | |/ _ \ | |_) | | | |
" | |___| |___ | ||  __/| |_) | |_| / ___ \|  _ <| |_| |
"  \____|_____|___|_|   |____/ \___/_/   \_\_| \_\____/ 
"                                                       
" 
""""""""""""""""""""""""""""""
set clipboard+=unnamedplus
map <^> :w !xclip<CR><CR>
vmap <^> "+y
map <S-^> :r!xclip -o<CR>


""""""""""""""""""""""""""""""
"     _   _   _ _____ ___  ____  _   _ _   _ 
"    / \ | | | |_   _/ _ \|  _ \| | | | \ | |
"   / _ \| | | | | || | | | |_) | | | |  \| |
"  / ___ \ |_| | | || |_| |  _ <| |_| | |\  |
" /_/   \_\___/  |_| \___/|_| \_\\___/|_| \_|
"                                            
" 
""""""""""""""""""""""""""""""

autocmd FileType rust nnoremap <leader><Enter> :! cargo run<cr>
autocmd FileType rust nnoremap <F5> :! cargo run<cr>

autocmd FileType py nnoremap <leader><Enter> :! python3 %<cr>
autocmd FileType py nnoremap <F5> :! python3 %<cr>

"""""""""""""""""""""""""""""
"     _   _   _ _____ ___  _____ ___  ____  __  __    _  _____ 
"    / \ | | | |_   _/ _ \|  ___/ _ \|  _ \|  \/  |  / \|_   _|
"   / _ \| | | | | || | | | |_ | | | | |_) | |\/| | / _ \ | |  
"  / ___ \ |_| | | || |_| |  _|| |_| |  _ <| |  | |/ ___ \| |  
" /_/   \_\___/  |_| \___/|_|   \___/|_| \_\_|  |_/_/   \_\_|  
"                                                              
" 
"""""""""""""""""""""""""""""
au FileType rust nnoremap <leader>f :RustFmt<cr>:w<cr>
au FileType py nnoremap <leader>f :Autopep8<cr>:q<cr>:w<cr>

autocmd FileType rust inoremap <p println!("");<Esc>2hi

""""""""""""""""""""""""""""""
"  ______   _______ _   _  ___  _   _ 
" |  _ \ \ / /_   _| | | |/ _ \| \ | |
" | |_) \ V /  | | | |_| | | | |  \| |
" |  __/ | |   | | |  _  | |_| | |\  |
" |_|    |_|   |_| |_| |_|\___/|_| \_|
"                                     
" 
""""""""""""""""""""""""""""""

autocmd FileType py inoremap <c def class :
autocmd FileType py inoremap <if if():
autocmd FileType py inoremap <fu def ():
autocmd FileType py inoremap <f for :
autocmd FileType py inoremap <main if __name__ == '__main__':<Enter>    

""""""""""""""""""""""""""""""
"  _         _____   __  __
" | |    __ |_   _|__\ \/ /
" | |   / _` || |/ _ \\  / 
" | |__| (_| || |  __//  \ 
" |_____\__,_||_|\___/_/\_\
"                          
" 
""""""""""""""""""""""""""""""
autocmd FileType tex inoremap <it \textit{}<Esc>T{i
autocmd FileType tex inoremap <fr \begin{frame}{}<Enter>\end{frame}<Esc>kf}f}i
autocmd FileType tex inoremap <bf \textbf{}<Esc>T{i
autocmd FileType tex inoremap <ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><Esc>3kA\item<Space>
autocmd FileType tex inoremap <il \begin{itemize}<Enter><Enter>\end{itemize}<Esc>kA\item<Space>
autocmd FileType tex inoremap <fi \begin{figure}<Enter><Enter>\end{figure}<Enter><Enter><Esc>3kA\includegraphics<Space>
autocmd FileType tex inoremap <li <Enter>\item<Space>
autocmd FileType tex inoremap <ref \ref{}<Space><Esc>T{i
autocmd FileType tex inoremap <tab \begin{tabular}<Enter><Enter>\end{tabular}<Enter><Enter><Esc>4kA{}<Esc>i
autocmd FileType tex inoremap <a \href{}{}<Space><Esc>2T{i
autocmd FileType tex inoremap <sec \section{}<Enter><Enter><Esc>2kf}i
autocmd FileType tex inoremap <ssec \subsection{}<Enter><Enter><Esc>2kf}i
autocmd FileType tex inoremap <sssec \subsubsection{} 2kf}i
autocmd FileType tex inoremap <nl \newline<Enter>
autocmd FileType tex inoremap <ref \textit{[ref]}
autocmd FileType tex inoremap <ar $\rightarrow$
