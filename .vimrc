set number                      "�Կ�ɽ��
set nocompatible                " vi�ȸߴ�������ʤ�
set backspace=indent,eol,start  "�Хå����ڡ����Ǻ���Ǥ���ʪ����ꤹ��
set nobackup                    "�Хå����åפ�Ȥ�ʤ�
set noswapfile                  "����åץե��������ʤ�
set title                       "�����ȥ��ɽ������
set wrap                        "�ޤ��֤�
set autoread                    "¾�ǥե�������ѹ������ä��鼫ư�ɤ߹���
set wildmenu                    "���ޥ�ɥ饤���䴰
set wildchar=<tab>              "���ޥ���䴰�򳫻Ϥ��륭��
set wildmode=list:longest
set completeopt=menu,preview,menuone
set showmatch matchtime=1       "���å��б�
syntax on                       "���󥿥å����ϥ��饤��
set cursorline                  "��������Ԥ�Ĵɽ��
set vb t_vb=                    "�ӡ��ײ����Ĥ餵�ʤ�

set list                        "�ԲĻ�ʸ��ɽ��
set listchars=tab:>.,trail:_,extends:>,precedes:< " �ԲĻ�ʸ����ɽ������

"����åץܡ��ɤ�Windows��Ϣ��
set clipboard=unnamed
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
"����������Ƭ�������ǻߤޤ�ʤ��褦�ˤ���
set whichwrap=b,s,h,l,<,>,[,]

"��������
set ignorecase      "��ʸ���Ⱦ�ʸ������̤��ʤ�
set smartcase       "��ʸ���Ⱦ�ʸ�����ޤޤ�Ƥ����餽�Τޤ�
set wrapscan		"�Ǹ�ޤǤ��ä���ǽ�����
set incsearch		"���󥯥��󥿥륵����
set hlsearch		"����ʸ����Ĵ

 "�������������Ƕ�Ĵ�õ�
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>
"���֡ʥ���ǥ�ȡ˼���
set noautoindent
set smartindent
set cindent
set expandtab
"���֤ζ����
set tabstop=4 shiftwidth=4 softtabstop=4

"���Ի��˼�ư�ǥ�����ʸ�����������Τ�̵���ˤ���
autocmd FileType * setlocal formatoptions-=ro

"���ѥ��ڡ������в�
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /??/

"ʸ�������ɤ�����
set encoding=EUC-JP
set termencoding=EUC-JP
set fileencoding=EUC-JP
set fileencodings=EUC-JP

"���ơ������饤��ˤĤ��Ƥ�����
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \ 
set statusline+=\ \ \ [%{&ff}/%Y/%{&enc}] 
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\ 
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

set showcmd			"������Υ��ޥ�ɤ򥹥ơ�������ɽ��
set cmdheight=1		"���ޥ�ɥ饤���ɽ��

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

" �����ȥ�����ɥ��ˤΤ߷��������
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

"�ݥåץ��åץ�˥塼�Υ��顼������
" �ϥ��饤�� on
syntax enable


" neocomplcache
let g:neocomplcache_enable_at_startup = 1 " ��ư����ͭ����
" �䴰����ư�ǳ��Ϥ����ʸ����
let g:neocomplcache_auto_completion_start_length = 3
" smarrt caseͭ������ ��ʸ�������Ϥ����ޤ���ʸ����ʸ���ζ��̤�̵�뤹��
let g:neocomplcache_enable_smart_case = 1
" camle case��ͭ��������ʸ������ڤ�Ȥ����磻��ɥ����ɤΤ褦�˿�����
let g:neocomplcache_enable_camel_case_completion = 1
" _(��������С�)���ڤ���䴰��ͭ����
let g:neocomplcache_enable_underbar_completion = 1
" ���󥿥å����򥭥�å��夹��Ȥ��κǾ�ʸ��Ĺ��3��
let g:neocomplcache_min_syntax_length = 3
" neocomplcache��ưŪ�˥�å�����Хåե�̾�Υѥ�����
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" -���Ϥˤ������ֹ��ɽ��
let g:neocomplcache_enable_quick_match = 1
"�ݥåץ��åץ�˥塼��ɽ����������ο�������ͤ�100
let g:neocomplcache_max_list = 20
" �䴰���䤬ɽ������Ƥ�����ϳ��ꡣ�����Ǥʤ����ϲ���
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"

" �Ĥ�ɽ������
let g:treeExplVertical=1
nmap <C-e> :VTreeExplore .<CR>

" Grep
" :Gb <args> ��GrepBuffer����
command! -nargs=1 Gb :GrepBuffer <args>
" �������벼��ñ���GrepBuffer����
nnoremap <C-g><C-b> :<C-u>GrepBuffer<Space><C-r><C-w><Enter>

colorscheme s2k1ta98

" set tags ����

" ���������פ�C-t ���� C-[ ��
nmap <c-[>  :pop<CR>

" ���ơ������饤���ɽ��
set statusline=%<     " �Ԥ�Ĺ������Ȥ����ڤ�ͤ�����
set statusline+=[%n]  " �Хåե��ֹ�
set statusline+=%m    " %m �����ե饰
set statusline+=%r    " %r �ɤ߹������ѥե饰
set statusline+=%h    " %h �إ�ץХåե��ե饰
set statusline+=%w    " %w �ץ�ӥ塼������ɥ��ե饰
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  "fenc��ff��ɽ��
set statusline+=%y    " �Хåե���Υե�����Υ�����
set statusline+=\     " ���򥹥ڡ���
if winwidth(0) >= 130
    set statusline+=%F    "�Хåե���Υե�����Υե�ѥ�
else
    set statusline+=%t    "�ե�����̾�Τ�
endif
set statusline+=%=    "���󤻹��ܤȱ��󤻹��ܤζ��ڤ�
"set statusline+=%{fugitive#statusline()}  "Git�Υ֥���̾��ɽ��
set statusline+=\ \   " ���򥹥ڡ���2��
set statusline+=%1l   ""�����ܤ˥������뤬���뤫
set statusline+=/
set statusline+=%L    "�Хåե������Կ�
set statusline+=,
set statusline+=%c    "�����ܤ˥������뤬���뤫
set statusline+=%V    "���̾�β����ܤ˥������뤬���뤫
set statusline+=\ \   "���򥹥ڡ���2��
set statusline+=%P    "�ե�������β���ΰ��֤ˤ��뤫

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
"set showtabline=2 " ��˥��֥饤���ɽ��
"
"" The prefix key.
"nnoremap    [Tag]   <Nop>
"nmap    t [Tag]
"" Tab jump
"for n in range(1, 9)
"  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
"endfor
"" t1 ��1�ֺ��Υ��֡�t2 ��1�ֺ�����2���ܤΥ��֤˥�����

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc ���������֤���ֱ��˺��
map <silent> [Tag]x :tabclose<CR>
" tx ���֤��Ĥ���
map <silent> [Tag]n :tabnext<CR>
" tn ���Υ���
map <silent> [Tag]p :tabprevious<CR>
" tp ���Υ���




"autocomplpop
autocmd FileType * let g:AutoComplPop_Completeoption = '.,w,b,u,t,i'
autocmd FileType php let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/php.dict'
autocmd FileType tpl let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/php.dict'


"<TAB>���䴰
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
