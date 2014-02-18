" Following lines added by drush vimrc-install on Mon, 24 Jun 2013 09:00:13 +0000.
set nocompatible
call pathogen#infect('~/.drush/vimrc/bundle')
call pathogen#infect('~/.vim/bundle')
" End of vimrc-install additions.

"call pathogen#infect()
let g:syntastic_phpcs_conf=" --standard=Drupal --extensions=php,module,inc,install,test,profile,theme"

set background=dark
syntax on

"if has("gui_running")
  let g:solarized_contrast = "high"
  let g:solarized_visibility= "high"
"endif

colorscheme solarized
set gfn=Source\ Code\ Pro\ Semibold:h14

let mapleader = ","

"set ts=4 sts=4 sw=4 noexpandtab
set expandtab
set tabstop=2
set shiftwidth=2

set hidden
set number
set ruler
set autoindent
set smartindent
set cursorline
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase
set scrolljump=5
set scrolloff=3
set foldenable
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set history=1000
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
set backupdir=/tmp//
set directory=/tmp//
set dir=/tmp//

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))


map <D-S-right> gt
map <D-S-left> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

autocmd FileType php set fileencoding=UTF-8
autocmd FileType html set fileencoding=UTF-8
autocmd FileType css set fileencoding=UTF-8

"autocmd vimenter * NERDTree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
  augroup END
end

" from https://github.com/spf13/spf13-vim/blob/master/.vimrc
if has('statusline')
  set laststatus=2
  " Broken down into easily includeable segments
  set statusline=%<%f\    " Filename
  set statusline+=%w%h%m%r " Options
  set statusline+=%{fugitive#statusline()} "  Git Hotness
  set statusline+=\ [%{&ff}/%Y]            " filetype
  set statusline+=\ [%{getcwd()}]          " current dir
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_enable_signs=1
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif


" Conflict markers {{{
" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" shortcut to jump to next conflict marker
nmap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
" }}}


" Sudo to write
cmap w!! w !sudo tee % >/dev/null

"; i command mode ger ; i slutet på raden
noremap ; :s/\([^;]\)$/\1;/<CR>


function! OpenPhpFunction (keyword)
  let proc_keyword = substitute(a:keyword , '_', '-', 'g')
  exe 'split'
  exe 'enew'
  exe "set buftype=nofile"
  exe 'silent r!lynx -dump -nolist http://www.php.net/manual/en/function.'.proc_keyword.'.php'
  exe 'norm gg'
  exe 'call search ("^' . a:keyword .'")'
  exe 'norm k'
  exe 'norm dgg'
  exe 'call search("User Contributed Notes")'
  exe 'norm dGgg'
endfunction
au FileType php map <c-K> :call OpenPhpFunction('<C-r><C-w>')<CR>


nnoremap <F3> :NumbersToggle<CR>


source $HOME/.vim/drupal-vim/plugin/drupal.vim

filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Valloric/YouCompleteMe'
"Bundle 'git://git.wincent.com/command-t.git'
Bundle 'scrooloose/nerdcommenter'
"Bundle 'joonty/vdebug.git'
Bundle 'altercation/vim-colors-solarized'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'terryma/vim-smooth-scroll'
Bundle 'terryma/vim-expand-region'
Bundle 'mihaifm/vimpanel'
Bundle 'sjl/gundo.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'bling/vim-airline'

filetype plugin indent on     " required!

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_auto_jump=0 " Dont jump to the first line with a problem

let g:ctrlp_working_path_mode = ''

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=Black
highlight Normal term=bold cterm=NONE ctermfg=White ctermbg=Black

" Bubble single lines. Killer feature called 'Line up/down' in Textmate.
nmap <C-Up> ddkP
nmap <C-Down> ddp

nnoremap <F5> :GundoToggle<CR>

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 25, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 25, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 25, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 25, 4)<CR>

map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)
