""新しい行のインデントを現在行と同じにする
set autoindent

"クリップボードをOSと連携する
set clipboard+=unnamed

"タブの代わりに空白文字を指定する
set expandtab

"タブ幅の設定
set tabstop=4

"変更中のファイルでも、保存しないで他のファイルを表示する
set hidden

"インクリメンタルサーチを行う
set incsearch

"行番号を表示する
set number

"閉括弧が入力された時、対応する括弧を強調する
set showmatch

" grep検索を設定する
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh

" 検索結果のハイライトをEsc連打でクリアする
nnoremap <ESC><ESC> :nohlsearch<CR>

" 全角スペースの表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkGray gui=reverse guifg=DarkGray
endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        "ZenkakuSpace をカラーファイルで設定するなら、
        "次の行をコメントアウト
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

" neobundle settings {{{
if has('vim_starting')
  " neobundle をインストールしていない場合は自動インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  " runtimepath の追加は必須
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

" neobundle#begin - neobundle#end の間に導入するプラグインを記載します。
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'fuenor/im_control.vim'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

" vimrc に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundleCheck
call neobundle#end()

filetype plugin indent on
set t_Co=256
syntax on
colorscheme jellybeans

" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1
 
" デフォルトでツリーを表示させる
"autocmd VimEnter * execute 'NERDTree'

if has('mac')
  if has('gui_running')
    let IM_CtrlMode = 4
  else
    let IM_CtrlMode = 1

    function! IMCtrl(cmd)
      let cmd = a:cmd
      if cmd == 'On'
        let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {104})" > /dev/null 2>&1')
      elseif cmd == 'Off'
        let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {102})" > /dev/null 2>&1')
      elseif cmd == 'Toggle'
        let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {55, 49})" > /dev/null 2>&1')
      endif
      return ''
    endfunction
  endif

  " 「日本語入力固定モード」のMacVimKaoriya対策を無効化
  let IM_CtrlMacVimKaoriya = 0
  " ctrl+jで日本語入力固定モードをOnOff
  inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>
endif

"他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a "google chrome"'
let g:vim_markdown_folding_disabled=1

" ブックマークを最初から表示
let g:NERDTreeShowBookmarks=1

" ファイル指定で開かれた場合はNERDTreeは表示しない
if !argc()
      autocmd vimenter * NERDTree|normal gg3j
endif

nnoremap <silent><C-e> :NERDTreeToggle<CR>
