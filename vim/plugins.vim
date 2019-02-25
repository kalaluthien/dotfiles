let s:darwin = has('mac')

" Plug buffers appear in a new tab
let g:plug_window = '-tabnew'


" UnPlug: deregister plugin, must be called before plug#end()
" https://github.com/junegunn/vim-plug/issues/469
function! s:deregister(repo)
  let repo = substitute(a:repo, '[\/]\+$', '', '')
  let name = fnamemodify(repo, ':t:s?\.git$??')
  call remove(g:plugs, name)
  call remove(g:plugs_order, index(g:plugs_order, name))
endfunction
command! -nargs=1 -bar UnPlug call s:deregister(<args>)

" for neovim plugins (rplugin)
if has('nvim')
    function! DoRemote(arg)
        UpdateRemotePlugins
    endfunction
endif


call plug#begin('~/.vim/plugged')

" General and Behaviour
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tweekmonster/helpful.vim', { 'on' : ['HelpfulVersion'] }
if has('patch-7.4.1154')  " requires v:false
  Plug 'embear/vim-localvimrc'
endif

" Integration and Interfaces
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-update-rc' }
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
if executable('tree')
    Plug 'mhinz/vim-tree'
endif
Plug 'vim-voom/VOoM', { 'on' : ['Voom', 'VoomToggle'] }
Plug 'tpope/vim-dispatch', { 'tag' : 'v1.1' }
if has('nvim') || v:version >= 800
    Plug 'neomake/neomake'
endif
Plug 'tpope/vim-tbone'
Plug 'szw/vim-maximizer'    " zoom and unzoom!
Plug 'junegunn/goyo.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'wookayin/vim-tmux-focus-events'   "A patched version of mine
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'rking/ag.vim'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/vim-easy-align'

" Utilities
Plug 'junegunn/vim-emoji'
Plug 'cocopon/colorswatch.vim', { 'on' : ['ColorSwatchGenerate'] }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'Lokaltog/vim-easymotion'
Plug 'unblevable/quick-scope'
Plug 'haya14busa/vim-asterisk'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 't9md/vim-quickhl'
if executable('diff') && has('patch-7.4.1685')
    Plug 'machakann/vim-highlightedundo'
endif

if v:version >= 800 || v:version == 704 && has('patch786')
    " requires vim 7.4.786+ (see issue #23)
    Plug 'machakann/vim-highlightedyank'
endif

Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/vim-peekaboo'
Plug 'sjl/gundo.vim'
Plug 'SirVer/ultisnips'
Plug 'vim-scripts/matchit.zip'
Plug 'tomtom/tlib_vim'
Plug 'junegunn/vader.vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tpope/vim-eunuch'
Plug 'rizzatti/dash.vim',   { 'on': 'Dash' }
Plug 'wookayin/vim-typora', { 'on': 'Typora' }
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" Syntax, Completion, Coding stuffs
Plug 'editorconfig/editorconfig-vim'

Plug 'sheerun/vim-polyglot'
Plug 'tmux-plugins/vim-tmux'

Plug 'klen/python-mode', { 'branch': 'develop' } |
  \ Plug 'wookayin/vim-python-enhanced-syntax'
Plug 'davidhalter/jedi-vim'
if has('nvim')
    Plug 'numirias/semshi', { 'do': function('DoRemote') }
    Plug 'stsewd/isort.nvim', { 'do': function('DoRemote') }
endif

Plug 'artur-shaik/vim-javacomplete2'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
"Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'lervag/vimtex', { 'for' : ['tex', 'plaintex'] }
Plug 'gisraptor/vim-lilypond-integrator'
Plug 'tfnico/vim-gradle'
Plug 'Tyilo/applescript.vim'
Plug 'rdolgushin/groovy.vim'

Plug 'Shougo/echodoc.vim'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-lua-ftplugin', { 'for' : ['lua'] }


" Completion engine for neovim (deoplete or language server)
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
    Plug 'zchee/deoplete-jedi'    " Python
    Plug 'zchee/deoplete-clang'   " C/C++
    Plug 'machakann/vim-Verdin', { 'for': ['vim'] }   " vimscript
    Plug 'zchee/deoplete-zsh', { 'for': ['zsh'] }     " zsh

elseif v:version >= 800

    " Vim 8.0: Alternative async-completor plugin
    " built-in support for python (jedi), java, etc.
    Plug 'maralla/completor.vim'

endif

" Asynchronous Lint Engine (ALE)
if has('nvim') || v:version >= 800
    Plug 'w0rp/ale'
endif

" *EXPERIMENTAL* language-server support (coc.nvim)
" Activated if the following conditions are met:
"    (i) Proper neovim version.
"    (ii) 'node' and 'yarn' are installed
"    (ii) ~/.config/nvim/coc-settings.json file exists
if has('nvim') && executable('yarn') &&
            \ isdirectory(expand("\~/.config/coc/"))

    " supercedes deoplete :)
    UnPlug 'Shougo/deoplete.nvim'
    Plug 'neoclide/coc.nvim', {'do': function('coc#util#install') }
endif




" Additional, optional local plugins
if filereadable(expand("\~/.vim/plugins.local.vim"))
    source \~/.vim/plugins.local.vim
endif

call plug#end()
delcom UnPlug
