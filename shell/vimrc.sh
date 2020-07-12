#! /bin/sh

cat > ~/.vimrc << eof
set nu              " 显示行号
syntax on           " 打开语法高亮
colorscheme desert  " 使用配色方案

set laststatus=1    " 总是显示状态行
set showcmd         " 状态栏显示当前执行的命令

"为不同的文件类型设置不同的空格数替换TAB
autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set ai
autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set sw=4
autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set ts=4
autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set sts=4
autocmd FileType javascript,html,css,xml set ai
autocmd FileType javascript,html,css,xml set sw=2
autocmd FileType javascript,html,css,xml set ts=2
autocmd FileType javascript,html,css,xml set sts=2

set ts=4            " tabstop，tab宽4个空格
set expandtab       " 允许拓展tab, noexpandtab不允许
set autoindent      " 继承前一行的缩进方式，特别适用于多行注释

" filetype on         " 打开文件类型检测功能
" filetype indent on  " 不同文件类型采用不同缩进
" filetype plugin on  " 允许使用插件
" filetype plugin indent on
eof


if false; then
    # TAB替换为空格：
    :set ts=4
    :set expandtab
    :%retab!

    # 空格替换为TAB：
    :set ts=4
    :set noexpandtab
    :%retab!
fi