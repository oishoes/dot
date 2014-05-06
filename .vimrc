set number                      "行数表示
set nocompatible                " viと互換を持たない
set backspace=indent,eol,start  "バックスペースで削除できる物を指定する
set nobackup                    "バックアップをとらない
set noswapfile                  "スワップファイルを作らない
set title                       "タイトルを表示する
set wrap                        "折り返し
set autoread                    "他でファイルに変更があったら自動読み込み
set wildmenu                    "コマンドライン補完
set wildchar=<tab>              "コマンド補完を開始するキー
set wildmode=list:longest
set completeopt=menu,preview,menuone
set showmatch matchtime=1       "カッコ対応
syntax on                       "シンタックスハイライト
set cursorline                  "カーソル行を強調表示
set vb t_vb=                    "ビープ音を鳴らさない

set list                        "不可視文字表示
set listchars=tab:>.,trail:_,extends:>,precedes:< " 不可視文字の表示形式

"クリップボードをWindowsと連携
set clipboard=unnamed
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

"検索設定
set ignorecase      "大文字と小文字を区別しない
set smartcase       "大文字と小文字が含まれていたらそのまま
set wrapscan		"最後までいったら最初に戻る
set incsearch		"インクリメンタルサーチ
set hlsearch		"一致文字強調

 "エスケープ二回で強調消去
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>
"タブ（インデント）周り
set noautoindent
set smartindent
set cindent
set expandtab
"タブの空白数
set tabstop=4 shiftwidth=4 softtabstop=4

"改行時に自動でコメント文が挿入されるのを無効にする
autocmd FileType * setlocal formatoptions-=ro

"全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /??/

"文字コードの設定
set encoding=EUC-JP
set termencoding=EUC-JP
set fileencoding=EUC-JP
set fileencodings=EUC-JP

"ステータスラインについての設定
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \ 
set statusline+=\ \ \ [%{&ff}/%Y/%{&enc}] 
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\ 
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

set showcmd			"入力中のコマンドをステータスに表示
set cmdheight=1		"コマンドラインを表示

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction

"}

augroup vimrc-auto-mkdir  " {{{
autocmd!
autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
function! s:auto_mkdir(dir, force)  " {{{
if !isdirectory(a:dir) && (a:force ||
		\    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
endif
endfunction  " }}}
augroup END  " }}}

" カレントウィンドウにのみ罫線を引く
augroup cch
autocmd! cch
autocmd WinLeave * set nocursorline
autocmd WinEnter,BufRead * set cursorline
augroup END
:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

if &term =~ "xterm-256color" || "screen-256color"
    set t_Co=256
    set t_Sf=[3%dm
    set t_Sb=[4%dm
elseif &term =~ "xterm-color"
    set t_Co=8
    set t_Sf=[3%dm
    set t_Sb=[4%dm
endif

source ~/.vimrc.bundle

"ポップアップメニューのカラーを設定
" ハイライト on
syntax enable


" neocomplcache
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化
" 補完が自動で開始される文字数
let g:neocomplcache_auto_completion_start_length = 3
" smarrt case有効化。 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
" camle caseを有効化。大文字を区切りとしたワイルドカードのように振る舞う
let g:neocomplcache_enable_camel_case_completion = 1
" _(アンダーバー)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1
" シンタックスをキャッシュするときの最小文字長を3に
let g:neocomplcache_min_syntax_length = 3
" neocomplcacheを自動的にロックするバッファ名のパターン
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" -入力による候補番号の表示
let g:neocomplcache_enable_quick_match = 1
"ポップアップメニューで表示される候補の数。初期値は100
let g:neocomplcache_max_list = 20
" 補完候補が表示されている場合は確定。そうでない場合は改行
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"

" 縦に表示する
let g:treeExplVertical=1
nmap <C-e> :VTreeExplore .<CR>

" Grep
" :Gb <args> でGrepBufferする
command! -nargs=1 Gb :GrepBuffer <args>
" カーソル下の単語をGrepBufferする
nnoremap <C-g><C-b> :<C-u>GrepBuffer<Space><C-r><C-w><Enter>

colorscheme s2k1ta98

" set tags 設定

" タグジャンプをC-t から C-[ に
nmap <c-[>  :pop<CR>

" ステータスラインの表示
set statusline=%<     " 行が長すぎるときに切り詰める位置
set statusline+=[%n]  " バッファ番号
set statusline+=%m    " %m 修正フラグ
set statusline+=%r    " %r 読み込み専用フラグ
set statusline+=%h    " %h ヘルプバッファフラグ
set statusline+=%w    " %w プレビューウィンドウフラグ
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  "fencとffを表示
set statusline+=%y    " バッファ内のファイルのタイプ
set statusline+=\     " 空白スペース
if winwidth(0) >= 130
    set statusline+=%F    "バッファ内のファイルのフルパス
else
    set statusline+=%t    "ファイル名のみ
endif
set statusline+=%=    "左寄せ項目と右寄せ項目の区切り
"set statusline+=%{fugitive#statusline()}  "Gitのブランチ名を表示
set statusline+=\ \   " 空白スペース2個
set statusline+=%1l   ""何行目にカーソルがあるか
set statusline+=/
set statusline+=%L    "バッファ内の総行数
set statusline+=,
set statusline+=%c    "何列目にカーソルがあるか
set statusline+=%V    "画面上の何列目にカーソルがあるか
set statusline+=\ \   "空白スペース2個
set statusline+=%P    "ファイル内の何％の位置にあるか

if has("clipboard") 
    vmap ,y "+y 
    nmap ,p "+gP 
    if has("gui_running") || has("xterm_clipboard") 
        silent! set clipboard^=unnamedplus 
        set clipboard^=unnamed 
    endif 
endif 


function! Incr()
    let a = line('.') - line("'<")
    let c = virtcol("'<")
    if a > 0
        execute 'normal! '.c.'|'.a."\<C-a>"
    endif
    normal `<
endfunction
vnoremap <C-a> :call Incr()<CR>


" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

"" Set tabline.
"function! s:my_tabline()  "{{{
"  let s = ''
"  for i in range(1, tabpagenr('$'))
"    let bufnrs = tabpagebuflist(i)
"    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
"    let no = i  " display 0-origin tabpagenr.
"    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
"    let title = fnamemodify(bufname(bufnr), ':t')
"    let title = '[' . title . ']'
"    let s .= '%'.i.'T'
"    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
"    let s .= no . ':' . title
"    let s .= mod
"    let s .= '%#TabLineFill# '
"  endfor
"  let s .= '%#TabLineFill#%T%=%#TabLine#'
"  return s
"endfunction "}}}
"let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
"set showtabline=2 " 常にタブラインを表示
"
"" The prefix key.
"nnoremap    [Tag]   <Nop>
"nmap    t [Tag]
"" Tab jump
"for n in range(1, 9)
"  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
"endfor
"" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ




"autocomplpop
autocmd FileType * let g:AutoComplPop_Completeoption = '.,w,b,u,t,i'
autocmd FileType php let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/php.dict'
autocmd FileType tpl let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/php.dict'


"<TAB>で補完
" {{{ Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or
    " if we want to try autocompletion
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
    return "\<TAB>"
    else
if pumvisible()
    return "\<C-N>"
    else
    return "\<C-N>\<C-P>"
    end
endif
endfunction
"""" Remap the tab key to select action with InsertTabWrapper
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"" }}} Autocompletion using the TAB key


hi Pmenu  term=standout ctermbg=gray
hi PmenuSel  term=standout ctermbg=4
hi PmenuSbar  term=standout ctermbg=2
hi PmenuThumb  term=standout ctermbg=3
