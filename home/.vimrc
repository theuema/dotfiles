" ----------------------------------- VIM-PLUG
" Automatic installation of vim-plug. A minimalist Vim plugin manager.
" Must be before plug#begin() call
if empty(glob('~/.config/vim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --- VIM-PLUG Section
call plug#begin('~/.config/vim/plugged')

" Plugin outside ~/.config/vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'jremmen/vim-ripgrep' " might now be already included in fzf.vim

" Install Conquer of Completion to make VIM smart with code completion support
" Info: only use with VIM >=8.1 (especially MacOS seems compatible with coc.nvim)
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Deactivate or change key mappings of the following snippet plugins 
" if using any code completion like ycm or coc.nvim plugin
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'

Plug 'zefei/vim-wintabs'
Plug 'zefei/vim-wintabs-powerline'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'terryma/vim-multiple-cursors'

" Statusbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color schemes
Plug 'junegunn/seoul256.vim'
"Plug 'arcticicestudio/nord-vim'

" Ctags
" Plug 'preservim/tagbar'
" Plug 'ctrlpvim/ctrlp.vim'
" Gutentags (creates and maintains tags on its own)
" Plug 'ludovicchabant/vim-gutentags'
" C/C++ completion with clang_complete
" Plug 'rip-rip/clang_complete'

" C-family Semantic Completion
" https://github.com/ycm-core/YouCompleteMe#c-family-semantic-completion
" If using CMake, add -DCMAKE_EXPORT_COMPILE_COMMANDS=ON when configuring (or add set( CMAKE_EXPORT_COMPILE_COMMANDS ON ) to CMakeLists.txt) and copy or symlink the generated database to the root of your project.

"function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
"  if a:info.status == 'installed' || a:info.force
"    !./install.py --clangd-completer
"  endif
"endfunction
" add folowing completers when needed
" --go-completer (needs mono) --rust-completer --java-completer --ts-completer (needs npm)

"Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

call plug#end()

" ----------------------------------- BASIC
" Remap <Leader> Key to Space
let mapleader = " "

" Change backspace behaviour for Debian based OS (see :help backspace)
set backspace=indent,eol,start

" --- FZF.vim 

" file finder is best used with a mapping. Mapping from :Files to Ctrl-f
" https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko
nnoremap <silent> <C-f> :Files<CR>

" Preview window for :Files command
" fzf#vim#with_preview internally executes bat for syntax highlighting
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(
    \ <q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" To search inside files, we can use FZF.vim's :Rg command. We map it to the Leader Key \+f
nnoremap <silent> <Leader>f :Rg<CR>

" --- ripgrep
" Vim has two ways to search in files: :vimgrep and :grep. :vimgrep uses vim's built-in grep and :grep uses external tool which you can reassign using 'grepprg'.
" Tell Vim to use ripgrep instead of grep by adding this inside our vimrc:
" When we run :grep inside Vim, it will run rg --vimgrep --smart-case --follow instead (Check man rg)
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" Side note: FZF.vim :Rg option also searches for file name in addition to the phrase.
" every time we invoke Rg, FZF + ripgrep will not consider filename as a match in Vim.

" insert manual colors before .shellescape()
" \ --colors "line:fg:128,128,128" --colors "path:fg:93,169,245" --colors "match:fg:195,232,141"

" Preview window for :Rg command
" fzf#vim#with_preview internally executes bat for syntax highlighting
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" --- SiverSearcher
" To search inside files we can also use SilverSearcher like on AArch64
" https://github.com/ggreer/the_silver_searcher
" sudo apt-get install silversearcher-ag || brew install the_silver_searcher
" nnoremap <silent> <Leader>f :Ag<CR>
" set grepprg=ag\ --vimgrep\ --smart-case\ --follow
" Set custom grepformat
" set grepformat=%f:%l:%c%m
" You can use Ag with ack.vim by adding the following line to your .vimrc:
" let g:ackprg = 'ag --vimgrep'

" --- FZF mappings:
" FZF.vim provides many other search commands
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

" --- Wintabs Plugin key mappings:"
map <C-H> <Plug>(wintabs_previous)
map <C-L> <Plug>(wintabs_next)
map <C-T>x <Plug>(wintabs_close)
map <C-T>u <Plug>(wintabs_undo)
map <C-T>o <Plug>(wintabs_only)
map <C-W>x <Plug>(wintabs_close_window)
map <C-W>o <Plug>(wintabs_only_window)
command! Tabc WintabsCloseVimtab
command! Tabo WintabsOnlyVimtab

" --- UltiSnips key mappings:"
" Trigger configuration. You need to change this to something other than <tab> 
" if you use one of the following
" https://github.com/Valloric/YouCompleteMe
" https://github.com/nvim-lua/completion-nvim
"let g:UltiSnipsExpandTrigger="<Tab>"
"let g:UltiSnipsJumpForwardTrigger="<C-b>"
"let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" make YCM compatible with UltiSnips (using supertab)
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" suggested to be <C-n> but changed to <C-p> due to vim-multiple-cursors (default) mapping
"let g:SuperTabDefaultCompletionType = '<C-p>'
" better key bindings for UltiSnipsExpandTrigger
"let g:UltiSnipsExpandTrigger = "<tab>"  
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" ---  terryma / vim-multiple-cursors re-mappings 
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" --- NERDTree key mappings:
nmap <F2> :NERDTreeToggle<CR>
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" --- Ctags
" Add tags files to your ctags lookup
"set tags+=./.git/tags
" -- Tell Gutentags to use the tags file in .git
"let g:gutentags_ctags_tagfile='./.git/tags'
" -- Tagbar key mappings:
"nmap <F3> :TagbarToggle<CR>
" -- Search through tags file(s)
"nnoremap <leader>. :CtrlPTag<CR>
" -- Search through all of the definitions of the last tag
"nnoremap <leader>, :ts<CR>
" Shift+1 / Shift+2 to navigate forward/backward in the tags stack
"map <F9> <C-T>
"map <F10> <C-]>

" -- Clang_complete
" Tell clang_complete where to find libclang
" let g:clang_library_path='usr/lib/llvm-6.0/lib/libclang.so.1'

" --- Tabs, Spaces and Indents
" Set the display style of tab character to → at the beginning and <space> inbetween
" Set the display character at the end of the line to ¬. 
" Set all spaces to display as characters, including the space at the beginning of the line, 
" the space in the middle of the line, and the space at the end of the line.
" Additionally add trail:· if we don't use space. (or directly add with :set lcs+=trail:·)
:set listchars=tab:\→\ ,eol:¬,space:·

" -- Toggle between TabSyntax on and off
" Default behaviour: off
function TabSyntaxToggle()
    if &list
        set nolist
    else
        set list
    endif
endfunction
nmap <F11> mz:execute TabSyntaxToggle()<CR>'z

" Different indents: autoindent, cindent and smartindent 
" Default: cindent=ON, autoindent=OFF, smartindent=OFF 
" set smarttab      " Inserts blanks on a <Tab> key (as per :sw, :ts and :sts).
" set autoindent    " Copy indent from current line when starting a new line.

" -- Toggle between tabs and spaces mapped to F9
" https://vim.fandom.com/wiki/Toggle_between_tabs_and_spaces
" https://vim.fandom.com/wiki/Converting_tabs_to_spaces

" Default behaviour: Spaces
set tabstop=4       " # of spaces when the tab key is pressed - "hard tabstop" (:ts).
set shiftwidth=4    " # of space characters inserted for indentation (:sw).
set softtabstop=4   " Causes <Tab> and <BS> to insert and delete the correct number of spaces. 
                    " When 0, feature is off (:sts). Enable when using spaces.
set expandtab       " Always uses tabs instead of space characters (:noet).

" Allow toggling between tabs and spaces
function TabToggle()
  if &expandtab " Use Tabs
    set noexpandtab     " Always uses tabs instead of space characters (:noet).
    set softtabstop=0
  else          " Use Spaces
    set expandtab       " Always uses spaces instead of tab characters (:et).
    set softtabstop=4   " Causes <Tab> and <BS> to insert and delete the correct number of spaces. 
                        " When 0, feature is off (:sts). Enable when using spaces.
  endif
endfunction
nmap <F12> mz:execute TabToggle()<CR>'z

" --- General (re)maps 
" Reload vimr configuration file shortcut
nnoremap <Leader>sc :source $MYVIMRC<CR>
" Press return to temporarily remove the highlighted search 
nnoremap <CR> :nohlsearch<CR><CR>
" Quickly turn the highlighting option on and off completely
nnoremap <leader>i :set incsearch!<CR>
nnoremap <leader>h :set hlsearch!<CR>
" If you don't have permission to write to the file without becoming super user, use w!!
cmap w!! %!sudo tee > /dev/null %
" Jump to the first non-blank character of the line with H
map H ^
" Jump to the end of the line with L
map L $
" Paste from yank register "0, which is not overwritten by dd
nnoremap <leader>yp "0p
xnoremap <leader>yp "0p
" Use Alt+Left/Right for jumping to the beginning of the words backwards/forwards
" Use `sed -n l` in terminal to evaluate the escaped sequence: e.g.; ^[f or ^[b
map <Esc>f w
map <Esc>b b

" --- General Configs
" Set line numbers
set number
" Don't see highlighting in insert mode as default 
autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch
" Highlight all search matches of /pattern
set hlsearch
" Highlight pattern in code while searching
set incsearch

" --- Move a line of text up/down using ALT+[jk], indent with ALT+[hl] 
"nnoremap <A-j> :m+<CR>==
"nnoremap <A-k> :m-2<CR>==
"nnoremap <A-h> <<
"nnoremap <A-l> >>
"inoremap <A-j> <Esc>:m+<CR>==gi
"inoremap <A-k> <Esc>:m-2<CR>==gi
"inoremap <A-h> <Esc><<`]a
"inoremap <A-l> <Esc>>>`]a
"vnoremap <A-j> :m'>+<CR>gv=gv
"vnoremap <A-k> :m-2<CR>gv=gv
"vnoremap <A-h> <gv
"vnoremap <A-l> >gv
" -- MAC: Find out which symbol you need to use when using the combination ALT+[jkhl] in insert mode
"nnoremap º :m+<CR>==
"nnoremap ∆ :m-2<CR>==
"nnoremap ª <<
"nnoremap @ >>
"inoremap º <Esc>:m+<CR>==gi
"inoremap ∆ <Esc>:m-2<CR>==gi
"inoremap ª <Esc><<`]a
"inoremap @ <Esc>>>`]a
"vnoremap º :m'>+<CR>gv=gv
"vnoremap ∆ :m-2<CR>gv=gv
"vnoremap ª <gv
"vnoremap @ >gv

" --- Color scheme
syntax on

" We find the installed color schemes in: ls -l /usr/share/vim/vim*/colors/ 
" Colorschemes installed via vim-plug

" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
let g:seoul256_background = 237
colo seoul256

" seoul256 (light):
"   Range:   252 (darkest) ~ 256 (lightest)
"let g:seoul256_light_background = 242
"colo seoul256-light

" Nord
"colo nord

" --- Statusbar Color Scheme
"let g:airline_theme='base16_nord'
