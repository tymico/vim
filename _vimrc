" --------- begin ---------

" ---------

" 关闭旧版兼容性
set nocompatible

" 文件有更改自动更新
set autoread

" 支持退格回到上一行
set backspace=indent,eol,start

" 模糊宽度为两个字符
set ambiwidth=double

" 文件编码格式
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,latin-1
set termencoding=utf-8

"set bomb? " 查询utf-8编码的bom标记 
"set nobomb " 开启utf-8编码的无bom标记 
set bomb " 开启utf-8编码的bom标记

" 解决console输出乱码
language messages zh_CN.utf-8

" 不自动生成备份文件
set nobackup

" 不产生交换文件
setlocal noswapfile

" 开启文件类型
filetype off    " vundle required!

" 开启插件
filetype plugin on

" 开启智能文件类型识别
filetype indent on

" 保留历史最大条目
set history=300

" 
set bufhidden=hide

" 支持系统剪切板，好像只在gvim中生效
set clipboard+=unnamed

" ---------

"
set whichwrap+=<,>,h,l

" 显示括号匹配情况
set magic

" 开启行号
set number

" 开启标尺
set ruler

" 打开自动折行
set wrap

" 智能缩进
set smartindent

" 缩进宽度为4
set shiftwidth=4

" 缩进宽度为4
set tabstop=4

" 缩进为4个空格
set softtabstop=4

"
set expandtab

" 
set dy=lastline

" 开启语法高亮
syntax on

" 即时搜索
set incsearch

" 打开搜索高亮
set hlsearch

" 显示配对
set showmatch

" 显示配对时间为2s
set matchtime=2

" 
set scrolloff=3

" 状态栏为2行
set laststatus=2

" 状态栏格式
set statusline=
set statusline+=[%f]\ 
set statusline+=%{(&fenc==\"\"?&enc:&fenc)}\ %{&ff}\ %Y\ 
set statusline+=[%v,%l/%L]\ %p%%\ 
set statusline+=[%{strftime(\"%Y/%m/%d\ %H:%M\")}]
set statusline+=%=
set statusline+=[0x%-2B]

" 
set brk=

" 智能缩进
set smarttab

" 
" set cursorline

" 智能切换目录
set autochdir

" 开启折叠
set foldenable

" 
set foldcolumn=0

" 
setlocal foldlevel=1

" 新打开的文件不折叠
"autocmd! BufNewFile,BufRead * setlocal nofoldenable
"au BufNewFile,BufRead *.txt set linespace=6

" 
set foldexpr=1

" 缩进方法
set foldmethod=indent
autocmd FileType c,cpp set foldmethod=syntax

" 缩进规则
if has("autocmd")
    filetype plugin indent on "根据文件进行缩进
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \ exe "normal! g`\"" |
                    \ endif
    augroup END
else
    "智能缩进，相应的有cindent，官方说autoindent可以支持各种文件的缩进，但是效果会比只支持C/C++的cindent效果会差一点，但笔者并没有看出来
    set autoindent " always set autoindenting on 
endif " has("autocmd")

" 设置gvim界面显示
if has("gui_running")
    set guioptions-=m	" 
    set guioptions-=T	" 
    set guioptions-=L	" 
    set guioptions-=r	" 
    set guioptions-=b	" 

    "set lines=60 columns=108

    " 窗口启动时自动最大化
    au GUIEnter * simalt ~x
endif

if(has("win32") || has("win95") || has("win64") || has("win16")) "判定当前操作系统类型
    let g:iswindows=1
else
    let g:iswindows=0
endif

" 设置字体
" set guifont=DejaVu\ Sans\ Mono\ h10
set guifont=Consolas:h11
"set guifont=黑体-繁:h11

" 设置颜色主题
colo ron
"colo hhteal

" 修改命令前缀,默认为'\'
let mapleader = ","

" 自动插入匹配括号
:inoremap ( ()<esc>i
:inoremap ) <c-r>=ClosePair(')')<cr>
:inoremap [ []<esc>i
:inoremap ] <c-r>=ClosePair(']')<cr>
:inoremap { {}<esc>i
:inoremap } <c-r>=ClosePair('}')<cr>
 
function! ClosePair(char)
    if getline('.')[col('.')-1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

" 定义F3插入时间
:imap <C-F3> <c-r>=strftime("%Y-%m-%d %w")<cr>


" 新建文件插入文件头
autocmd BufNewFile *.[ch],*.hpp,*.cpp exec ":call SetTitle()" 

" 定义F4热键，写文件头注释
map <F4> ms:call TitleDet()<cr>'s

" 加入注释
func AddTitleComment()
    call append(0, "/**") 
    call append(1, " * Filename:  ".expand("%:t"))
    call append(2, " * Created:   ".strftime("%Y/%m/%d %H:%M:%S")) 
    call append(3, " * Modified:  ".strftime("%Y/%m/%d %H:%M:%S"))
    call append(4, " * Author:    wangzhongtang") 
    call append(5, " * Copyright: 2007-2011 (C) Copyright by Shanghai iESLab Co., Ltd.")
    call append(6, " * Description:   ") 
    call append(7, " * ") 
    call append(8, " **/")
endfunc

" 定义函数SetTitle，自动插入文件头 
func SetTitle()
    if expand("%:e") == 'hpp'
        call AddTitleComment()
        call append(9, "#ifndef _".toupper(expand("%:t:r"))."_H") 
        call append(10, "#define _".toupper(expand("%:t:r"))."_H") 
        call append(11, "#ifdef __cplusplus") 
        call append(12, "extern \"C\"") 
        call append(13, "{") 
        call append(14, "#endif") 
        call append(15, "") 
        call append(16, "#ifdef __cplusplus") 
        call append(17, "}") 
        call append(18, "#endif") 
        call append(19, "#endif // _".toupper(expand("%:t:r"))."_H") 
    elseif expand("%:e") == 'h'
        call AddTitleComment()
        call append(9, "#ifndef _".toupper(expand("%:t:r"))."_H") 
        call append(10, "#define _".toupper(expand("%:t:r"))."_H") 
        call append(11, "") 
        call append(12, "#endif // _".toupper(expand("%:t:r"))."_H") 
    elseif &filetype =='c' 
        call append(0, "#include \"".expand("%:t:r").".h\"") 
    elseif &filetype =='cpp' 
        call append(0, "#include \"".expand("%:t:r").".h\"") 
    endif
endfunc

" 更新最近修改时间和文件名
function UpdateTitle()
    " 注意，这里从１开始为第１行
    "call setline(2, " * Filename:  ".expand("%:t"))
    call setline(4, " * Modified:  ".strftime("%Y/%m/%d %H:%M:%S"))
endf

" 判断前10行代码里面，是否有Modified这个单词，
" 如果没有的话，代表没有添加过作者信息，需要新添加；
" 如果有的话，那么只需要更新即可
function TitleDet()
    let n = 1
    " 默认为添加
    while n < 10
        let line = getline(n)
        if line =~ '^.*Modified.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    "call AddTitleComment()
endfunction

"保存时更新时间
au BufWritePost *.h,*.hpp : call TitleDet()


" ---------- plugin begin ----------

" ctags
    map <F12> :call Do_CsTag()<CR>
    nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
    nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
    nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    function Do_CsTag()
        let dir = getcwd()
        if filereadable("tags")
            if(g:iswindows==1)
                let tagsdeleted=delete(dir."\\"."tags")
            else
                let tagsdeleted=delete("./"."tags")
            endif
            if(tagsdeleted!=0)
                echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
                return
            endif
        endif
        if has("cscope")
            silent! execute "cs kill -1"
        endif
        if filereadable("cscope.files")
            if(g:iswindows==1)
                let csfilesdeleted=delete(dir."\\"."cscope.files")
            else
                let csfilesdeleted=delete("./"."cscope.files")
            endif
            if(csfilesdeleted!=0)
                echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
                return
            endif
        endif
        if filereadable("cscope.out")
            if(g:iswindows==1)
                let csoutdeleted=delete(dir."\\"."cscope.out")
            else
                let csoutdeleted=delete("./"."cscope.out")
            endif
            if(csoutdeleted!=0)
                echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
                return
            endif
        endif
        if(executable('ctags'))
            "silent! execute "!ctags -R --c-types=+p --fields=+S *"
            silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
        endif
        if(executable('cscope') && has("cscope") )
            if(g:iswindows!=1)
                silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
            else
                silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
            endif
            silent! execute "!cscope -b"
            execute "normal :"
            if filereadable("cscope.out")
                execute "cs add cscope.out"
            endif
        endif
        execute "!pause"
    endfunction

set tags+=d:/IDE/cpp_src/tags
"set tags+=d:/IDE/Qt/Qt5.2.0/5.2.0/msvc2012/include/tags

" omniCppComplete
    set completeopt=menu
    autocmd FileType c set omnifunc=ccomplete#Complete
    let OmniCpp_NamespaceSearch = 1
    let OmniCpp_GlobalScopeSearch = 1
    let OmniCpp_ShowAccess = 1
    let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
    let OmniCpp_MayCompleteDot = 1      " 输入 .  后自动补全
    let OmniCpp_MayCompleteArrow = 1    " 输入 -> 后自动补全
    let OmniCpp_MayCompleteScope = 1    " 输入 :: 后自动补全
    let OmniCpp_DefaultNamespaces = ["std"]
    imap <a-/> <c-x><c-o>

"" taglist
    " 因为我们放在环境变量里，所以可以直接执行
    "let Tlist_Ctags_Cmd='d:/IDE/cscope-15.7a/ctags.exe' 
    "让窗口显示在右边，0的话就是显示在左边
    "let Tlist_Use_Right_Window=1
    "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
    "let Tlist_Show_One_File=0 
    "非当前文件，函数列表折叠隐藏
    "let Tlist_File_Fold_Auto_Close=1 
    "当taglist是最后一个分割窗口时，自动推出vim
    "let Tlist_Exit_OnlyWindow=1 
    "是否一直处理tags.1:处理;0:不处理。不是一直实时更新tags，因为没有必要
    "let Tlist_Process_File_Always=0 
    "let Tlist_Inc_Winwidth=0

" tagbar
    nmap <Leader>tb :TagbarToggle<CR> "快捷键设置
    let g:tagbar_ctags_bin = 'd:/IDE/cscope-15.7a/ctags.exe' "ctags程序的路径
    let g:tagbar_width = 30 "窗口宽度的设置
    let g:tagbar_left = 1
"    map <F3> :Tagbar<CR> "autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen() "如果是c语言的程序的话，tagbar自动开启

" NERD_commenter
let NERDShutUp=1

"" DoxygenToolkit
    map <Leader>dx :Dox<cr>
    let g:DoxygenToolkit_authorName="wangzhongtang"
    let g:DoxygenToolkit_licenseTag="wangzhongtang's license\<enter>"
    let g:DoxygenToolkit_undocTag="DOXIGEN_SKIP_BLOCK"
    let g:DoxygenToolkit_briefTag_pre = "@brief\t"
    let g:DoxygenToolkit_paramTag_pre = "@param\t"
    let g:DoxygenToolkit_returnTag = "@return\t"
    let g:DoxygenToolkit_briefTag_funcName = "no"
    let g:DoxygenToolkit_maxFunctionProtoLines = 30

" NERD_tree
    let g:NERDTree_title="[NERDTree]"
    function! NERDTree_Start()
        exe 'NERDTree'
    endfunction
    function! NERDTree_IsValid()
        return 1
    endfunction
    let NERDTreeIgnore = ['\.sln', '\.sdf', '\.user', '\.filters', '\.vcxproj', '\.suo'
                    \ , '\.exe', '\.jpeg', '\.jpg', '\.bmp'
                    \ , '\.out', '\.files', '^tags'
                    \ , '^release$', '^debug$'
                    \ , '^Makefile']

"" winManager
    let g:winManagerWindowLayout = 'NERDTree'
    let g:winManagerWidth = 30
    nmap <Leader>wm :WMToggle<cr>

" ---------- plugin end ----------

" ---------- vundle begin ---------
"set rtp+=~/.vim/bundle/vundle/ "linux|unix载入特定目录插件
set rtp+=$HOME/.vim/bundle/vundle/ "Windows下载入用户目录插件
call vundle#rc()
  
" let Vundle manage Vundle  
" required!   
Bundle 'gmarik/vundle'  

" My Bundles here:  /* 插件配置格式 */  
"     
" original repos on github （Github网站上非vim-scripts仓库的插件，按下面格式填写）  
"Bundle 'tpope/vim-fugitive'  
"Bundle 'Lokaltog/vim-easymotion'  
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}  
"Bundle 'tpope/vim-rails.git'  
"Bundle 'fholgado/minibufexpl.vim'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/emmet-vim'
Bundle 'kevinw/pyflakes-vim'

" vim-scripts repos  （vim-scripts仓库里的，按下面格式填写）  
"Bundle 'L9'  
"Bundle 'FuzzyFinder'  
"Bundle 'taglist.vim'
Bundle 'bufexplorer.zip' 
Bundle 'the-NERD-tree'
Bundle 'The-NERD-Commenter' 
Bundle 'a.vim'
Bundle 'OmniCppComplete'
Bundle 'winmanager'
Bundle 'DoxygenToolkit.vim'
Bundle 'python.vim'

" non github repos   (非上面两种情况的，按下面格式填写)  
"Bundle 'git://git.wincent.com/command-t.git'  

" ...   


filetype plugin indent on     " required!   /** vimrc文件配置结束 **/  
"                                           /** vundle命令 **/  
" Brief help  
" :BundleList          - list configured bundles  
" :BundleInstall(!)    - install(update) bundles  
" :BundleSearch(!) foo - search(or refresh cache first) for foo   
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles  
"     
" see :h vundle for more details or wiki for FAQ   
" NOTE: comments after Bundle command are not allowed..


" ---------- vundle end ---------

" ---------- end ----------
