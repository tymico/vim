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
"set statusline+=[%{ALEGetStatusLine()}] 
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
autocmd FileType python set omnifunc=python3complete#Complete

" 缩进规则
if has("autocmd")
    filetype plugin indent on "根据文件进行缩进
    augroup vimrcEx
        au!
        "autocmd FileType text setlocal textwidth=78
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
set guifont=Consolas:h12

" 设置颜色主题
"colo ron
colo desert 

" 修改命令前缀,默认为'\'
let mapleader = ","

function! ClosePair(char)
    if getline('.')[col('.')-1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

" 新建文件插入文件头
autocmd BufNewFile *.[ch],*.hpp,*.cpp exec ":call SetTitle()" 

" 加入注释
func AddTitleComment()
    let l:lineNO = 0
    call append(l:lineNO, "/**") 
    let l:lineNO = l:lineNO + 1
    call append(l:lineNO, " * Filename:  ".expand("%:t"))
    let l:lineNO = l:lineNO + 1
    call append(l:lineNO, " * Created:   ".strftime("%Y/%m/%d %H:%M:%S")) 
    let l:lineNO = l:lineNO + 1
    "call append(l:lineNO, " * Modified:  ".strftime("%Y/%m/%d %H:%M:%S"))
    "let l:lineNO = l:lineNO + 1
    call append(l:lineNO, " * Author:    moe") 
    let l:lineNO = l:lineNO + 1
    call append(l:lineNO, " * Copyright: 2007-2011 (C) Copyright by moe.")
    let l:lineNO = l:lineNO + 1
    call append(l:lineNO, " * Description:   ") 
    let l:lineNO = l:lineNO + 1
    call append(l:lineNO, " * ") 
    let l:lineNO = l:lineNO + 1
    call append(l:lineNO, " **/")
endfunc

" 定义函数SetTitle，自动插入文件头 
func SetTitle()
    let l:lineNO = 8
    if expand("%:e") == 'hpp'
        call AddTitleComment()
        call append(l:lineNO, "#ifndef _".toupper(expand("%:t:r"))."_H") 
        let l:lineNO = l:lineNO + 1
        call append(l:lineNO, "#define _".toupper(expand("%:t:r"))."_H") 
        let l:lineNO = l:lineNO + 1
        call append(l:lineNO, "#ifdef __cplusplus") 
        let l:lineNO = l:lineNO + 1
        call append(l:lineNO, "extern \"C\"") 
        let l:lineNO = l:lineNO + 1
        call append(l:lineNO, "{") 
        let l:lineNO = l:lineNO + 1
        call append(l:lineNO, "#endif") 
        let l:lineNO = l:lineNO + 1
        call append(l:lineNO, "") 
        let l:lineNO = l:lineNO + 1
        call append(l:lineNO, "#ifdef __cplusplus") 
        let l:lineNO = l:lineNO + 1
        call append(l:lineNO, "}") 
        let l:lineNO = l:lineNO + 1
        call append(l:lineNO, "#endif") 
        let l:lineNO = l:lineNO + 1
        call append(l:lineNO, "#endif /* _".toupper(expand("%:t:r"))."_H */") 
    elseif expand("%:e") == 'h'
        call AddTitleComment()
        call append(l:lineNO, "#ifndef _".toupper(expand("%:t:r"))."_H") 
        let l:lineNO = l:lineNO + 1
        call append(l:lineNO, "#define _".toupper(expand("%:t:r"))."_H") 
        let l:lineNO = l:lineNO + 1
        call append(l:lineNO, "") 
        let l:lineNO = l:lineNO + 1
        call append(l:lineNO, "#endif /* _".toupper(expand("%:t:r"))."_H */") 
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
    "call setline(4, " * Modified:  ".strftime("%Y/%m/%d %H:%M:%S"))
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


" ---------- shortcut ----------
" 自动插入匹配括号
    :inoremap ( ()<esc>i
    :inoremap ) <c-r>=ClosePair(')')<cr>
    :inoremap [ []<esc>i
    :inoremap ] <c-r>=ClosePair(']')<cr>
    :inoremap { {}<esc>i
    :inoremap } <c-r>=ClosePair('}')<cr>

" 定义F4热键，写文件头注释
    imap <C-F4> <esc>:call SetTitle()<cr>
 
" 定义F3插入时间
    :imap <C-F3> <c-r>=strftime("%Y-%m-%d %w")<cr>

" 添加函数注释
    imap <F3> <esc>:Dox<cr>
    nmap <F3> :Dox<cr>

" Quickfix窗口相关
    " 跳转到下/上一个提示
    nmap <C-j> :cn<cr>
    nmap <C-k> :cp<cr>

" ---------- plugin begin ----------

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
                    \ , '\.pdb', '\.exp', '\.ilk', '\.dll', '\.obj'
                    \ , '\.exe', '\.jpeg', '\.jpg', '\.bmp'
                    \ , '\.meta'
                    \ , '\.out', '\.files', '^tags'
                    \ , '^release$', '^debug$' , '^Release$', '^Debug$'
                    \ , '\.Debug$', '\.Release$', '\.debug$', '\.release$']

"" winManager
    let g:winManagerWindowLayout = 'NERDTree'
    let g:persistentBehaviour = 0
    let g:winManagerWidth = 30
    nmap <Leader>wm :WMToggle<cr>

" for ycm
    let g:ycm_error_symbol = '.✗'
    let g:ycm_warning_symbol = '.Ϟ'
    let g:ycm_server_python_interpreter="C:/App/Python/Python35/python.exe"
    nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
    nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
    nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
    nmap <F4> :YcmDiags<CR>
    "关闭加载.ycm_extra_conf.py提示
    let g:ycm_confirm_extra_conf=0
    " 开启 YCM 基于标签引擎
    let g:ycm_collect_identifiers_from_tags_files=1
    " 从第2个键入字符就开始罗列匹配项
    let g:ycm_min_num_of_chars_for_completion=2
    " 禁止缓存匹配项,每次都重新生成匹配项
    let g:ycm_cache_omnifunc=0
    " 语法关键字补全
    let g:ycm_seed_identifiers_with_syntax=1
    "在注释输入中也能补全
    let g:ycm_complete_in_comments = 1
    "在字符串输入中也能补全
    let g:ycm_complete_in_strings = 1
    "注释和字符串中的文字也会被收入补全
    let g:ycm_collect_identifiers_from_comments_and_strings = 0

" for vim-indent-guides
    let g:indent_guides_enable_on_vim_startup = 1

" for ale
    "保持侧边栏可见
    "let g:ale_sign_column_always = 1
    " 状态栏信息格式
    let g:ale_statusline_format = ['✗ %d', 'Ϟ %d', '✔ ok']
    " 错误和警告标识符
    let g:ale_sign_error = '.✗'
    let g:ale_sign_warning = '.Ϟ'
    " 命令行消息
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    " 跳转错误行快捷键
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)
    
" for vint
    let g:syntastic_vim_checkers = ['vint']

" for vim-jsbeautify
    map <leader>jf :call JsBeautify()<cr>

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

" vim-scripts repos  （vim-scripts仓库里的，按下面格式填写）  
"Bundle 'L9'  
"Bundle 'FuzzyFinder'  
"Bundle 'taglist.vim'

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

" 输出
Bundle 'Kuniwak/vint'

" 语法高亮
Bundle 'mattn/emmet-vim'
Bundle 'othree/html5.vim'
Bundle 'ap/vim-css-color'
Bundle 'javascript-syntax'

" 缩进标记
Bundle 'nathanaelkane/vim-indent-guides'

" h/c,cpp快捷切换
Bundle 'a.vim'

" 代码注释
Bundle 'The-NERD-Commenter' 
Bundle 'DoxygenToolkit.vim'

" 代码格式化
Bundle 'google/yapf'
" js格式化，依赖nodejs
Bundle 'maksimr/vim-jsbeautify'

" 窗口管理
Bundle 'winmanager'
Bundle 'bufexplorer.zip' 

" 文件浏览
Bundle 'the-NERD-tree'

" ShaderLab语法高亮
Bundle 'http://git.oschina.net/qiuchangjie/ShaderHighLight'

" 语法检查
Bundle 'scrooloose/syntastic'
"python语法检查，与syntastic冲突
"Bundle 'w0rp/ale'
"js语法检查
Bundle 'lint.vim'

" 调试
Bundle 'vim-scripts/gdbmgr'

" C#语法高亮
Bundle 'csharp.vim'
" js语法高亮
Bundle 'pangloss/vim-javascript'

" 运行后台任务: AsyncRun xxx
Bundle 'skywind3000/asyncrun.vim'
" 文件搜索
Bundle 'ctrlpvim/ctrlp.vim'
" 模糊搜索当前文件中所有函数
Bundle 'tacahiroy/ctrlp-funky'
" 批量搜索
Bundle 'rking/ag.vim'
" 代码补全，需要cmake,python,omnisharp
Bundle 'Valloric/YouCompleteMe'
" need OmiSharp start the server automatically and for running asynchronous builds.
Bundle 'tpope/vim-dispatch'
" C#语法补全，需要Python编译
"Bundle 'OmniSharp/omnisharp-vim'
" Python补全
Bundle 'davidhalter/jedi-vim'

" ColorScheme
Bundle 'tomasr/molokai'
Bundle 'freya'
Bundle 'altercation/vim-colors-solarized'

" ---------- vundle end ---------

" ---------- end ----------
