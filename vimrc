scriptencoding utf-8
" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
" An example for a Japanese version vimrc file.
" 日本語版のデフォルト設定ファイル(vimrc) - Vim 7.4
"
" Last Change: 22-Jun-2018.
" Maintainer:  MURAOKA Taro <koron.kaoriya@gmail.com>
"
" 解説:
" このファイルにはVimの起動時に必ず設定される、編集時の挙動に関する設定が書
" かれています。GUIに関する設定はgvimrcに書かかれています。
"
" 個人用設定は_vimrcというファイルを作成しそこで行ないます。_vimrcはこのファ
" イルの後に読込まれるため、ここに書かれた内容を上書きして設定することが出来
" ます。_vimrcは$HOMEまたは$VIMに置いておく必要があります。$HOMEは$VIMよりも
" 優先され、$HOMEでみつかった場合$VIMは読込まれません。
"
" 管理者向けに本設定ファイルを直接書き換えずに済ませることを目的として、サイ
" トローカルな設定を別ファイルで行なえるように配慮してあります。Vim起動時に
" サイトローカルな設定ファイル($VIM/vimrc_local.vim)が存在するならば、本設定
" ファイルの主要部分が読み込まれる前に自動的に読み込みます。
"
" 読み込み後、変数g:vimrc_local_finishが非0の値に設定されていた場合には本設
" 定ファイルに書かれた内容は一切実行されません。デフォルト動作を全て差し替え
" たい場合に利用して下さい。
"
" 参考:
"   :help vimrc
"   :echo $HOME
"   :echo $VIM
"   :version

"---------------------------------------------------------------------------
" サイトローカルな設定($VIM/vimrc_local.vim)があれば読み込む。読み込んだ後に
" 変数g:vimrc_local_finishに非0な値が設定されていた場合には、それ以上の設定
" ファイルの読込を中止する。
if 1 && filereadable($VIM . '/vimrc_local.vim')
  unlet! g:vimrc_local_finish
  source $VIM/vimrc_local.vim
  if exists('g:vimrc_local_finish') && g:vimrc_local_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" ユーザ優先設定($HOME/.vimrc_first.vim)があれば読み込む。読み込んだ後に変数
" g:vimrc_first_finishに非0な値が設定されていた場合には、それ以上の設定ファ
" イルの読込を中止する。
if 1 && exists('$HOME') && filereadable($HOME . '/.vimrc_first.vim')
  unlet! g:vimrc_first_finish
  source $HOME/.vimrc_first.vim
  if exists('g:vimrc_first_finish') && g:vimrc_first_finish != 0
    finish
  endif
endif

" plugins下のディレクトリをruntimepathへ追加する。
for s:path in split(glob($VIM.'/plugins/*'), '\n')
  if s:path !~# '\~$' && isdirectory(s:path)
    let &runtimepath = &runtimepath.','.s:path
  end
endfor
unlet s:path

"---------------------------------------------------------------------------
" 日本語対応のための設定:
"
" ファイルを読込む時にトライする文字エンコードの順序を確定する。漢字コード自
" 動判別機能を利用する場合には別途iconv.dllが必要。iconv.dllについては
" README_w32j.txtを参照。ユーティリティスクリプトを読み込むことで設定される。
source $VIM/plugins/kaoriya/encode_japan.vim
" メッセージを日本語にする (Windowsでは自動的に判断・設定されている)
if !(has('win32') || has('mac')) && has('multi_lang')
  if !exists('$LANG') || $LANG.'X' ==# 'X'
    if !exists('$LC_CTYPE') || $LC_CTYPE.'X' ==# 'X'
      language ctype ja_JP.eucJP
    endif
    if !exists('$LC_MESSAGES') || $LC_MESSAGES.'X' ==# 'X'
      language messages ja_JP.eucJP
    endif
  endif
endif
" MacOS Xメニューの日本語化 (メニュー表示前に行なう必要がある)
if has('mac')
  set langmenu=japanese
endif
" 日本語入力用のkeymapの設定例 (コメントアウト)
if has('keymap')
  " ローマ字仮名のkeymap
  "silent! set keymap=japanese
  "set iminsert=0 imsearch=0
endif
" 非GUI日本語コンソールを使っている場合の設定
if !has('gui_running') && &encoding != 'cp932' && &term == 'win32'
  set termencoding=cp932
endif

"---------------------------------------------------------------------------
" メニューファイルが存在しない場合は予め'guioptions'を調整しておく
if 1 && !filereadable($VIMRUNTIME . '/menu.vim') && has('gui_running')
  set guioptions+=M
endif

"---------------------------------------------------------------------------
" Bram氏の提供する設定例をインクルード (別ファイル:vimrc_example.vim)。これ
" 以前にg:no_vimrc_exampleに非0な値を設定しておけばインクルードはしない。
if 1 && (!exists('g:no_vimrc_example') || g:no_vimrc_example == 0)
  if &guioptions !~# "M"
    " vimrc_example.vimを読み込む時はguioptionsにMフラグをつけて、syntax on
    " やfiletype plugin onが引き起こすmenu.vimの読み込みを避ける。こうしない
    " とencに対応するメニューファイルが読み込まれてしまい、これの後で読み込
    " まれる.vimrcでencが設定された場合にその設定が反映されずメニューが文字
    " 化けてしまう。
    set guioptions+=M
    source $VIMRUNTIME/vimrc_example.vim
    set guioptions-=M
  else
    source $VIMRUNTIME/vimrc_example.vim
  endif
endif

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=4
" タブをスペースに展開しない (expandtab:展開する)
set expandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" 自動インデントの幅(tabstopと同じ値が望ましい)
set shiftwidth=4
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を非表示 (number:表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
colorscheme molokai " (Windows用gvim使用時はgvimrcを編集すること)

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
set nobackup
" スワップファイルを作成しない
set noswapfile
" アンドゥファイルを生成しない
set noundofile


"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix') && !has('gui_running')
  let s:uname = system('uname')
  if s:uname =~? "linux"
    set term=builtin_linux
  elseif s:uname =~? "freebsd"
    set term=builtin_cons25
  elseif s:uname =~? "Darwin"
    set term=beos-ansi
  else
    set term=builtin_xterm
  endif
  unlet s:uname
endif

"---------------------------------------------------------------------------
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定

" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif

"---------------------------------------------------------------------------
" KaoriYaでバンドルしているプラグインのための設定

" autofmt: 日本語文章のフォーマット(折り返し)プラグイン.
set formatexpr=autofmt#japanese#formatexpr()

" vimdoc-ja: 日本語ヘルプを無効化する.
if kaoriya#switch#enabled('disable-vimdoc-ja')
  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimdoc-ja"'), ',')
endif

" vimproc: 同梱のvimprocを無効化する
if kaoriya#switch#enabled('disable-vimproc')
  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]vimproc$"'), ',')
endif

" go-extra: 同梱の vim-go-extra を無効化する
if kaoriya#switch#enabled('disable-go-extra')
  let &rtp = join(filter(split(&rtp, ','), 'v:val !~ "[/\\\\]plugins[/\\\\]golang$"'), ',')
endif

" added

" 無名レジスタに入るデータを、*レジスタにも入れる。
set clipboard+=unnamed

" 「o」と「O」実行後にノーマルモードに遷移
" noremap o o<ESC>
" noremap O O<ESC>

" Tabでインデント調整
noremap <tab> i<tab><ESC>

" Jでスペースなし行結合
noremap J gJ

" ビープ音のオフ
set vb t_vb=

" 色んなコマンドモード遷移
inoremap <silent> jj <ESC>
inoremap <silent> っj <ESC>

" 全角スペースの表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

" .md, .mkd を markdown と認識させる
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.mkd set filetype=markdown
" .memo を markdown と認識させる
au BufRead,BufNewFile *.memo set filetype=markdown

" encoding
set encoding=utf-8
set fileencodings=utf-8,shift-jis
set fileformats=unix,dos,mac

" 折り返し桁数と縦線表示
" set textwidth=97
" let &colorcolumn=&textwidth

" <leader> を Space に変更する
let mapleader = "\<Space>"

" :w, :q を <leader>w, <leader>q に変更する
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" ft conversion
nnoremap <leader>html :set ft=html<CR>
nnoremap <leader>php :set ft=php<CR>

"-------------------------
" NERDTree関連の設定
"-------------------------
" 起動時に自動で NERDTree 起動
" 起動時に開いたファイルにカーソルを移動する( <C-r> -> h )
" function s:MoveToFileAtStart()
"   call feedkeys("\<C-w>")
"   call feedkeys("\h")
" endfunction
" 
" autocmd VimEnter *  NERDTree | call s:MoveToFileAtStart()

" NERDTree を右側に
let g:NERDTreeWinPos="right"

"<C-e>でNERDTreeをオンオフ。いつでもどこでも。
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>

" 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" winnr("$") : winnr がウィンドウ番号、$が最後
" b:NERDTree : カレントバッファの NERDTree

" NERDTreeの新規タブオープン時、元タブのNERDTreeを閉じる
" autocmd Tableave * if (b:NERDTree.isTabTree()) | b:NERDTree.NERDTreeClose | endif

"-------------------------
" NeoComplete関連の設定
"-------------------------
" neocomplete を起動時にオンにする
let g:neocomplete#enable_at_startup = 1

" snippet のディレクトリ設定（neosnippetedit のときに必須）
let g:neosnippet#snippets_directory='~/.vim/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets'

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

"-------------------------
" Misc設定
"-------------------------
" airline(status_bar) のテーマ
let g:airline_theme = 'violet'

" Shift + h(left) or + r(right) でタブを左右に移動
nnoremap <S-h> :tabprevious<CR>
nnoremap <S-l> :tabnext<CR>

" edamame 編集用に行幅を 70 に設定する関数
function! Edamame() " デフォルト引数、引数を与えて色々したい。
    set textwidth=70
    let &colorcolumn=&textwidth
endfunction

" 差分コメント表示プラグインの有効化（gitファイルにのみ有効）
" let g:gitgutter_highlight_lines = 1
let g:gitgutter_max_signs = 2000 " マークの最大数

" タブ番号:バッファ名
" フォーマットはステータスラインと同じ
set guitablabel=%N:%t

" vimgrep, grep, Ggrep 後に自動で cwindow(Quickfix window)を開く
autocmd QuickFixCmdPost *grep* cwindow

" sonictemplate 用 template フォルダの指定
let g:sonictemplate_vim_template_dir = $HOME.'/Documents/dotfiles/sonictemplate'

" tablist.vim 用設定
" set tags=tags
" let Tlist_Ctags_Cmd        = "C:\Windows\ctags.exe"
" let Tlist_Show_One_File    = 1 " 現在表示中のファイルのみのタグしか表示しない
" let Tlist_Use_Right_Window = 1 " 右側にtag listのウィンドウを表示する
" let Tlist_Exit_OnlyWindow  = 1 " taglistのウィンドウだけならVimを閉じる
" map <silent> <leader>l :TlistToggle<CR> " \lでtaglistウインドウを開いたり閉じたり出来るショートカット

" カレントディレクトリを自動で切り替える
" :echo exists("+autochdir") の結果が 0 の場合は利用不可
set autochdir

" 選択範囲を検索するキーマッピング
vnoremap z/ <ESC>/\%V
vnoremap z? <ESC>?\%V

" Filetype が PHP で保存時にシンタックスエラーをチェックする
" autocmd FileType php set makeprg=php\ -l\ %
" autocmd BufWritePost *.php silent make | if len(getqflist()) != 1 | copen | else | cclose | endif
                
" PHP Lint 
" nmap <leader>l :call PHPLint()<CR>
" function PHPLint()
"     let result = system( &ft . ' -l ' . bufname(""))
"     echo result
" endfunction

" インデントハイライトをデフォルトでオフ -> 描画処理が重すぎて実用的でない
let g:indent_guides_enable_on_vim_startup = 0
" let g:indent_guides_start_level = 2 " 深さ 2 から開始
" let g:indent_guides_auto_colors = 0 " オリジナル背景色にする -> 案外調整が難しいため保留
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#2E2E2E ctermbg=233
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#424242 ctermbg=235

" シンタックスチェック関連設定
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0 " ファイルオープン時はチェックしない
"let g:syntastic_check_on_wq = 1 " 閉じる際はチェックする
"let g:syntastic_enable_signs = 1
"let g:syntastic_echo_current_error = 1
"let g:syntastic_enable_highlighting = 1
"let g:syntastic_php_php_args = '-l'

" PHP ファイルの場合のみ自動チェック
"let g:syntastic_mode_map = {
"    \ 'mode': 'passive',
"    \ 'active_filetypes': ['php']
"    \}

" vim-ref の設定
" let g:ref_phpmanual_path = $HOME . '/.vim/ref/php-bigxhtml.html'

" ころころさせない！
let g:i_am_not_pika_beast = 1

" Copyright (C) 2009-2016 KaoriYa/MURAOKA Taro
