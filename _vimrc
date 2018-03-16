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
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')

call dein#end()

filetype plugin indent on
