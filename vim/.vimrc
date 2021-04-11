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

" leader
let mapleader = ","
let maplocalleader = mapleader

call plug#begin()

Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-scripts/closetag.vim'
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/localvimrc'
Plug 'mattn/emmet-vim'
Plug 'vim-scripts/grep.vim'
Plug 'vim-scripts/taglist-plus'
Plug 'vim-scripts/snipMate'
Plug 'vim-scripts/Align'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
" fzf include ripgrep Rg
"Plug 'jremmen/vim-ripgrep'
"Plug 'vim-scripts/fcitx.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'


" https://github.com/terryma/vim-multiple-cursors
Plug 'terryma/vim-multiple-cursors'

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

" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

" buffer https://github.com/jlanzarotta/bufexplorer
" Plug 'jlanzarotta/bufexplorer'

" autojump Plugin https://github.com/padde/jump.vim
Plug 'padde/jump.vim'

" vim and tmux window/pane navigation
" Ctrl-hjkl\ 연동
Plug 'christoomey/vim-tmux-navigator'

Plug 'hashivim/vim-terraform'

Plug 'ntpeters/vim-better-whitespace'
call plug#end()

filetype plugin indent on     " required!

" For Programming
set nomousehide
set hlsearch
set ignorecase
set incsearch
set smartcase
set noswapfile
syntax on
set ai
set smartindent
set synmaxcol=128
" 상대/절대 줄번호 조합
set relativenumber
set number
" long line 으로 인해 너무 느릴때 처리 - 그래도 느리면 :syntax off 호출할것.
set ttyfast " u got a fast terminal
set ttyscroll=3
set lazyredraw " to avoid scrolling problems

" clipboard - system clipboard 사용하게 변경. vim-gtk3 로 설치돼 있어야함.
" https://www.youtube.com/watch?v=jfLABzLRCwo
" Copy & Paste Like Windows - https://superuser.com/a/189198/368299
" Linux 에서 PRIMARY 로 작동함.
set clipboard=unnamedplus
vmap <C-c> "+yi
vmap <C-x> "+c
"vmap <C-v> c<ESC>"+p " 작동 안했음.
imap <C-v> <ESC>"+pa
" imap <C-v> <C-r><C-o>+

set laststatus=2
" au BufNewFile,BufRead *.java :source ~/.vim/myjava.vim
" au BufNewFile,BufRead *.js :source ~/.vim/myjs.vim
" au BufNewFile,BufRead *.html,*.css :source ~/.vim/myhtml.vim
augroup mkd
    autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END

au BufNewFile,BufRead *.groovy setf groovy
au BufNewFile,BufRead *.gradle setf groovy


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
set guioptions-=T " Toolbar 숨기기
set guioptions-=m " 메뉴 바 숨기기
set guioptions-=r " 오른쪽 스크롤바 숨기기
set guioptions-=L " 왼쪽 스크롤바 숨기기
"set toolbariconsize=large

set fileformats=unix,dos
set fileencodings=utf8,cp949

" Vim plug 자동 설치 전에는 해당 스킴이 없어서 오류가 발생함. 이를 없애는
" 방법. slient! ...
silent! colorscheme darktooth
"silent! colorscheme desertEx
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

" Terminal
map <Leader><Leader>t <ESC>:below terminal<CR>

" NERDTree
let NERDSpaceDelims=1
let NERDTreeIgnore=['\.vim$', '\~$', '.*\.class$', '\.pyc$', 'CVS', 'classes','.*\.jar$', 'target']
map <F12> :NERDTreeToggle<CR>

" 현재 편집창에 열린 파일을 NERDTree 에서 활성화 시켜준다.
nmap <Leader>n :NERDTreeFind<CR>

" nerdtree 창에서는 다른 파일 못열게 하기. vim-plug 사용시 충돌 방지
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
let g:plug_window = 'noautocmd vertical topleft new'

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

" fzf Buffers 가 화살표키 이동이 불가한 경우는 버퍼가 단 두개뿐일때. 그 외는
" 화살표 이동 작동함.
"
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

" vim-rooter
let g:rooter_targets = '/,*'
let g:rooter_patterns = ['.git', 'Makefile', 'settings.gradle']
let g:rooter_silent_chdir = 1

" fzf
" fzf 자체의 vim 기본 플러그인을 로딩해야한다. fzf.vim 과 다름.
"call fzf#run(fzf#wrap({'source': 'fdfind --type file --type directory --follow --hidden --exclude ".git .class" --color=always'}))

nnoremap <C-n> :Files<Cr>
let g:zf_preview_window = 'right:60%'
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Mapping selecting mappings
" normal mode mappings
nmap <leader><tab> <plug>(fzf-maps-n)
" visual mode mappings
xmap <leader><tab> <plug>(fzf-maps-x)
" operator-pending mappings
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

" 256 Colors Cheat sheet : https://jonasjacek.github.io/colors/
" cursor line/column highlight
" https://vim.fandom.com/wiki/Highlight_current_line
"hi CursorLine   cterm=NONE ctermbg=darkblue ctermfg=white guibg=darkred guifg=white
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
"nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
hi CursorLine   cterm=NONE ctermbg=239 guibg=gray39
hi CursorColumn cterm=NONE ctermbg=239 guibg=gray39
hi CursorLineNR cterm=bold ctermbg=239 guibg=gray39
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
set nocursorline
set nocursorcolumn

" Vim 모양새
" vim airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='molokai'

" Status Line
hi VertSplit ctermfg=black ctermbg=black
hi StatusLine ctermfg=black
hi StatusLineNC ctermfg=black

" nrformats : 숫자와 알파벳 증가시키기 ^A, ^X
set nrformats+=alpha

" trailing white space
highlight ExtraWhitespace ctermbg=yellow
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" gi-gutter config
highlight GitGutterAdd ctermfg=2 guifg=Green
highlight GitGutterChange ctermfg=3 guifg=Olive
highlight GitGutterDelete ctermfg=1 guifg=Maroon
highlight GitGutterChangeDelete ctermfg=4 guifg=Navy

nmap ) <Plug>(GitGutterNextHunk)
nmap ( <Plug>(GitGutterPrevHunk)

let g:gitgutter_enabled = 0
let g:gitgutter_map_keys = 0

" 아래 두줄이 있어야만 최좌측 기호 컬럼 색깔이 정상 작동함
" https://github.com/airblade/vim-gitgutter/issues/614
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn

" javascript/typescript

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
