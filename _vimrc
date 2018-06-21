if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('mattn/emmet-vim') " HTML support(構文入力後、C-y -> ,)
call dein#add('scrooloose/nerdcommenter') " コメント化／解除
call dein#add('scrooloose/nerdtree') " ディレクトリツリー
call dein#add('cohama/lexima.vim') " 括弧補完
call dein#add('tomasr/molokai') " colorscheme molokai
" deoplete (闇の力を与えられた新補完フレームワーク！) は、NeoVim or VIM8 + Python3 のため、
" 諦めた。Neocomplete にすべき。
call dein#add('Shougo/neocomplete')
call dein#add('Shougo/neosnippet') " スニペット。設定を忘れず。
call dein#add('Shougo/neosnippet-snippets') " さらにスニペット
call dein#add('vim-airline/vim-airline') " ステータスバーをかっこよく
call dein#add('vim-airline/vim-airline-themes') " かっこよさに磨きをかける
call dein#add('airblade/vim-gitgutter') " 左端に差分表示
call dein#add('mattn/sonictemplate-vim') " テンプレート管理
call dein#add('tmhedberg/matchit') " % 拡張によるペアマッチ機能
call dein#add('vim-scripts/zoom.vim') " +/- でズームイン／アウト！
call dein#add('vim-scripts/taglist.vim') " 関数／変数を ctags でリスト化
call dein#add('nathanaelkane/vim-indent-guides') " インデントを可視化
call dein#add('scrooloose/syntastic.git') " シンタックスチェック
call dein#add('thinca/vim-ref') " マニュアルを Vim 上で見る！
" call dein#add('Shougo/vimproc.vim') " 非同期実行を可能にする（vim-ref用）
" vim-ref はなかなかハードルが高い。w3m入れたり。
call dein#add('bcicen/vim-vice') " あわーい色のカラースキーマ

call dein#end()

filetype plugin indent on
