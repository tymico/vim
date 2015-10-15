" --------- begin ---------

" ---------

" �رվɰ������
set nocompatible

" �ļ��и����Զ�����
set autoread

" ֧���˸�ص���һ��
set backspace=indent,eol,start

" ģ�����Ϊ�����ַ�
set ambiwidth=double

" �ļ������ʽ
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,latin-1
set termencoding=utf-8

"set bomb? " ��ѯutf-8�����bom��� 
"set nobomb " ����utf-8�������bom��� 
set bomb " ����utf-8�����bom���

" ���console�������
language messages zh_CN.utf-8

" ���Զ����ɱ����ļ�
set nobackup

" �����������ļ�
setlocal noswapfile

" �����ļ�����
filetype off    " vundle required!

" �������
filetype plugin on

" ���������ļ�����ʶ��
filetype indent on

" ������ʷ�����Ŀ
set history=300

" 
set bufhidden=hide

" ֧��ϵͳ���а壬����ֻ��gvim����Ч
set clipboard+=unnamed

" ---------

"
set whichwrap+=<,>,h,l

" ��ʾ����ƥ�����
set magic

" �����к�
set number

" �������
set ruler

" ���Զ�����
set wrap

" ��������
set smartindent

" �������Ϊ4
set shiftwidth=4

" �������Ϊ4
set tabstop=4

" ����Ϊ4���ո�
set softtabstop=4

"
set expandtab

" 
set dy=lastline

" �����﷨����
syntax on

" ��ʱ����
set incsearch

" ����������
set hlsearch

" ��ʾ���
set showmatch

" ��ʾ���ʱ��Ϊ2s
set matchtime=2

" 
set scrolloff=3

" ״̬��Ϊ2��
set laststatus=2

" ״̬����ʽ
set statusline=
set statusline+=[%f]\ 
set statusline+=%{(&fenc==\"\"?&enc:&fenc)}\ %{&ff}\ %Y\ 
set statusline+=[%v,%l/%L]\ %p%%\ 
set statusline+=[%{strftime(\"%Y/%m/%d\ %H:%M\")}]
set statusline+=%=
set statusline+=[0x%-2B]

" 
set brk=

" ��������
set smarttab

" 
" set cursorline

" �����л�Ŀ¼
set autochdir

" �����۵�
set foldenable

" 
set foldcolumn=0

" 
setlocal foldlevel=1

" �´򿪵��ļ����۵�
"autocmd! BufNewFile,BufRead * setlocal nofoldenable
"au BufNewFile,BufRead *.txt set linespace=6

" 
set foldexpr=1

" ��������
set foldmethod=indent
autocmd FileType c,cpp set foldmethod=syntax

" ��������
if has("autocmd")
    filetype plugin indent on "�����ļ���������
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \ exe "normal! g`\"" |
                    \ endif
    augroup END
else
    "������������Ӧ����cindent���ٷ�˵autoindent����֧�ָ����ļ�������������Ч�����ֻ֧��C/C++��cindentЧ�����һ�㣬�����߲�û�п�����
    set autoindent " always set autoindenting on 
endif " has("autocmd")

" ����gvim������ʾ
if has("gui_running")
    set guioptions-=m	" 
    set guioptions-=T	" 
    set guioptions-=L	" 
    set guioptions-=r	" 
    set guioptions-=b	" 

    "set lines=60 columns=108

    " ��������ʱ�Զ����
    au GUIEnter * simalt ~x
endif

if(has("win32") || has("win95") || has("win64") || has("win16")) "�ж���ǰ����ϵͳ����
    let g:iswindows=1
else
    let g:iswindows=0
endif

" ��������
" set guifont=DejaVu\ Sans\ Mono\ h10
set guifont=Consolas:h11
"set guifont=����-��:h11

" ������ɫ����
colo ron
"colo hhteal

" �޸�����ǰ׺,Ĭ��Ϊ'\'
let mapleader = ","

" �Զ�����ƥ������
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

" ����F3����ʱ��
:imap <C-F3> <c-r>=strftime("%Y-%m-%d %w")<cr>


" �½��ļ������ļ�ͷ
autocmd BufNewFile *.[ch],*.hpp,*.cpp exec ":call SetTitle()" 

" ����F4�ȼ���д�ļ�ͷע��
map <F4> ms:call TitleDet()<cr>'s

" ����ע��
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

" ���庯��SetTitle���Զ������ļ�ͷ 
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

" ��������޸�ʱ����ļ���
function UpdateTitle()
    " ע�⣬����ӣ���ʼΪ�ڣ���
    "call setline(2, " * Filename:  ".expand("%:t"))
    call setline(4, " * Modified:  ".strftime("%Y/%m/%d %H:%M:%S"))
endf

" �ж�ǰ10�д������棬�Ƿ���Modified������ʣ�
" ���û�еĻ�������û����ӹ�������Ϣ����Ҫ����ӣ�
" ����еĻ�����ôֻ��Ҫ���¼���
function TitleDet()
    let n = 1
    " Ĭ��Ϊ���
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

"����ʱ����ʱ��
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
    let OmniCpp_ShowPrototypeInAbbr = 1 " ��ʾ���������б�
    let OmniCpp_MayCompleteDot = 1      " ���� .  ���Զ���ȫ
    let OmniCpp_MayCompleteArrow = 1    " ���� -> ���Զ���ȫ
    let OmniCpp_MayCompleteScope = 1    " ���� :: ���Զ���ȫ
    let OmniCpp_DefaultNamespaces = ["std"]
    imap <a-/> <c-x><c-o>

"" taglist
    " ��Ϊ���Ƿ��ڻ�����������Կ���ֱ��ִ��
    "let Tlist_Ctags_Cmd='d:/IDE/cscope-15.7a/ctags.exe' 
    "�ô�����ʾ���ұߣ�0�Ļ�������ʾ�����
    "let Tlist_Use_Right_Window=1
    "��taglist����ͬʱչʾ����ļ��ĺ����б������ֻ��1��������Ϊ1
    "let Tlist_Show_One_File=0 
    "�ǵ�ǰ�ļ��������б��۵�����
    "let Tlist_File_Fold_Auto_Close=1 
    "��taglist�����һ���ָ��ʱ���Զ��Ƴ�vim
    "let Tlist_Exit_OnlyWindow=1 
    "�Ƿ�һֱ����tags.1:����;0:����������һֱʵʱ����tags����Ϊû�б�Ҫ
    "let Tlist_Process_File_Always=0 
    "let Tlist_Inc_Winwidth=0

" tagbar
    nmap <Leader>tb :TagbarToggle<CR> "��ݼ�����
    let g:tagbar_ctags_bin = 'd:/IDE/cscope-15.7a/ctags.exe' "ctags�����·��
    let g:tagbar_width = 30 "���ڿ�ȵ�����
    let g:tagbar_left = 1
"    map <F3> :Tagbar<CR> "autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen() "�����c���Եĳ���Ļ���tagbar�Զ�����

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
"set rtp+=~/.vim/bundle/vundle/ "linux|unix�����ض�Ŀ¼���
set rtp+=$HOME/.vim/bundle/vundle/ "Windows�������û�Ŀ¼���
call vundle#rc()
  
" let Vundle manage Vundle  
" required!   
Bundle 'gmarik/vundle'  

" My Bundles here:  /* ������ø�ʽ */  
"     
" original repos on github ��Github��վ�Ϸ�vim-scripts�ֿ�Ĳ�����������ʽ��д��  
"Bundle 'tpope/vim-fugitive'  
"Bundle 'Lokaltog/vim-easymotion'  
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}  
"Bundle 'tpope/vim-rails.git'  
"Bundle 'fholgado/minibufexpl.vim'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/emmet-vim'
Bundle 'kevinw/pyflakes-vim'

" vim-scripts repos  ��vim-scripts�ֿ���ģ��������ʽ��д��  
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

" non github repos   (��������������ģ��������ʽ��д)  
"Bundle 'git://git.wincent.com/command-t.git'  

" ...   


filetype plugin indent on     " required!   /** vimrc�ļ����ý��� **/  
"                                           /** vundle���� **/  
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
