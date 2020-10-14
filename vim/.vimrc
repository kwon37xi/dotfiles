" :vim set fileencoding=utf8
" vim-plug auto-install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set encoding=utf8 " windows 에서 사용시 필수
set nocompatible
set backupdir=~/.local/tmp/vim/backup
set directory=~/.local/tmp/vim/swap
set undodir=~/.local/tmp/vim/undos
set nomousehide
set ignorecase
set smartcase

" Copy & Paste Like Windows
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" leader
let mapleader = ","
let maplocalleader = mapleader

call plug#begin()

Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-scripts/closetag.vim'
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/localvimrc'
"Plug 'vim-scripts/bufexplorer.zip'
Plug 'mattn/emmet-vim'
Plug 'vim-scripts/grep.vim'
Plug 'vim-scripts/taglist-plus'
Plug 'vim-scripts/snipMate'
Plug 'vim-scripts/Align'
Plug 'bling/vim-airline'
Plug 'editorconfig/editorconfig-vim'
Plug '/home/linuxbrew/.linuxbrew/opt/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'jremmen/vim-ripgrep'
"Plug 'vim-scripts/fcitx.vim'

" Programming Languages
Plug 'vim-scripts/python.vim'
Plug 'vim-scripts/ruby.vim'
Plug 'vim-scripts/groovy.vim'

" Color Schemes
Plug 'vim-scripts/Zenburn'
Plug 'vim-scripts/pyte'
Plug 'vim-scripts/desertEx'
Plug 'tomasr/molokai'
Plug 'https://github.com/mswift42/vim-themes.git'

" File Type
Plug 'elzr/vim-json'

call plug#end()

filetype plugin indent on     " required!

" For Programming
set nu
syntax on
set ai
set smartindent
set clipboard=unnamed
set synmaxcol=128
" long line 으로 인해 너무 느릴때 처리 - 그래도 느리면 :syntax off 호출할것.
set ttyfast " u got a fast terminal
set ttyscroll=3
set lazyredraw " to avoid scrolling problems

set laststatus=2
" au BufNewFile,BufRead *.java :source ~/.vim/myjava.vim
" au BufNewFile,BufRead *.js :source ~/.vim/myjs.vim
" au BufNewFile,BufRead *.html,*.css :source ~/.vim/myhtml.vim
augroup mkd
    autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END

au BufNewFile,BufRead *.gradle :set filetype=groovy

" Vim 7.0 탭 매핑 from http://www.vim.org/tips/tip.php?tip_id=1221
map th :tabprev<CR>
map tl :tabnext<CR>
map tn :tabnew<CR>
map td :tabclose<CR>

" Make
map <F9> :make<CR>

" GUI 설정
set guifont=D2Coding\ 14
"set guifont=NanumGothicCoding\ 12
"set guifont=Hwsr_9pt\ 9
"set guifont=DejaVu\ Sans\ Mono\ 11
"set guifont=Fixedsys\ Excelsior\ 3.01\ 12

" 툴바 안보이게 - 툴바를 안보이게 하면 화면 split 시에 커서가 사라짐
" set guioptions-=T

set fileformats=unix,dos
set fileencodings=utf8,cp949

" Vim plug 자동 설치 전에는 해당 스킴이 없어서 오류가 발생함. 이를 없애는
" 방법. slient! ...
silent! colorscheme desertEx
"colorscheme zenburn
"colorscheme desertEx
"silent! colorscheme pyte
" colorscheme molokai
" colorscheme warm-night

" 기본 들여쓰기
set sw=4 sts=4 ts=4 et

" Insert Mode 단축키 추가
imap <S-Enter> <ESC>o
imap <C-S-Enter> <ESC>O
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-h> <Left>
imap <C-l> <Right>


" NERDTree
let NERDSpaceDelims=1
let NERDTreeIgnore=['\.vim$', '\~$', '.*\.class$', '\.pyc$', 'CVS', 'classes','.*\.jar$', 'target']
map <F12> :NERDTreeToggle<CR>

" closetags
let g:closetag_html_style=1
" Ctrl+Shift+-  : 를 누르면 가장 가까운 안 닫힌 태그 찾아 닫아줌
" if (has("win32") || has("win64"))
"     au Filetype html,xml,xsl,rhtml,ftl,jsp,jspf,tag source $VIMRUNTIME/../vimfiles/scripts/closetag.vim
" else
"     au Filetype html,xml,xsl,rhtml,ftl,jsp,jspf,tag source $HOME/.vim/scripts/closetag.vim
" endif

" indentLine
let g:indentLine_char = '┆'
let g:indentLine_color_term = 'lightblue'
let g:indentLine_color_gui = 'lightblue'

" indent for tab
set list lcs=tab:\┆\.,trail:~

" Buffer 단축키
map <leader>bp <esc>:bp<CR>
map <leader>bn <ESC>:bn<CR>
map <C-PageUp> :bp<CR>
map <C-PageDown> :bn<CR>
map <C-S-Tab> :bp<CR>
map <C-Tab> :bn<CR>
map <C-F4> :bdelete<CR>
map <leader>bd <ESC>:bdelete<CR>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.exe,*.class
"
" localvimrc 설정
let g:localvimrc_name = ".lvimrc"
let g:localvimrc_ask = 0

" bufexplorer
map <Leader>be <ESC>:Buffers<CR>
nnoremap <silent> <C-E> <ESC>:Buffers<CR>

" Emmet.vim (Zen-Coding)
" http://mattn.github.io/emmet-vim/
" https://raw.github.com/mattn/emmet-vim/master/TUTORIAL
" Ctrl+y+,

" for Grep plugin
" http://www.vim.org/scripts/script.php?script_id=311
map <leader>gn :cnext<CR>
map <leader>gp :cprev<CR>
nnoremap <expr> <silent> <C-A-Down>   (&diff ? "]c" : ":cnext\<CR>")
nnoremap <expr> <silent> <C-A-Up> (&diff ? "[c" : ":cprev\<CR>")

" Recursive grep :Rgrep -i 검색어 *.txt
" close grep window :cclose

" TagList-plus
" https://github.com/int3/vim-taglist-plus
let Tlist_Inc_Winwidth=0
let Tlist_Use_Right_Window=1
nnoremap <silent> <F11> :TlistToggle<CR>
nnoremap <silent> <C-F11> :w<CR>:TlistUpdate<CR>

" Open in Browser
nnoremap <leader>wf :exe ':silent !firefox %'<CR>
nnoremap <leader>wc :exe ':silent !chromium-browser %'<CR>
nnoremap <leader>wo :exe ':silent !opera %'<CR>
nnoremap <leader>wi :exe ':silent !iexplore %'<CR>

" editorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" toggle movement
function! ToggleMovement(firstOp, thenOp)
  let pos = getpos('.')
  execute "normal! " . a:firstOp
  if pos == getpos('.')
    execute "normal! " . a:thenOp
  endif
endfunction

" The original carat 0 swap
nnoremap <silent> 0 :call ToggleMovement('^', '0')<CR>

" How about ; and ,
nnoremap <silent> ; :call ToggleMovement(';', ',')<CR>
nnoremap <silent> , :call ToggleMovement(',', ';')<CR>

" How about H and L
nnoremap <silent> H :call ToggleMovement('H', 'L')<CR>
nnoremap <silent> L :call ToggleMovement('L', 'H')<CR>

" disable json hidden quote
let g:indentLine_setConceal = 0
let g:vim_json_syntax_conceal = 0
set conceallevel=0

" fzf
" fzf 자체의 vim 기본 플러그인을 로딩해야한다. fzf.vim 과 다름.
"call fzf#run(fzf#wrap({'source': 'fdfind --type file --type directory --follow --hidden --exclude ".git .class" --color=always'}))

nnoremap <C-n> :Files<Cr>
let g:zf_preview_window = 'right:60%'
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
" 단어를 사용하다가 단축키를 호출하면 단어 완성 기능
imap <c-x><c-k> <plug>(fzf-complete-word)

" 문서 작성도중 파일 경로 넣기
imap <c-x><c-f> <plug>(fzf-complete-path)

" 현재 파일에 있는 특정 줄 내용을 paste
imap <c-x><c-l> <plug>(fzf-complete-line)

" Empty value to disable preview window altogether
let g:fzf_preview_window = ''

" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" sytastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 0
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" 각 PC별 특별 설정이 있다면 ~/.vimrc_pc 파일을 만들어
" 해당 파일에 설정을 넣어 두면 된다.
if (filereadable($HOME . "/.vimrc_pc"))
    :source $HOME/.vimrc_pc
endif
