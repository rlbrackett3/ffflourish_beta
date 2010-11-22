let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <S-Tab> =BackwardsSnippet()
map! <S-Insert> <MiddleMouse>
snoremap <silent> 	 i<Right>=TriggerSnippet()
snoremap  b<BS>
snoremap % b<BS>%
snoremap ' b<BS>'
snoremap U b<BS>U
snoremap \ b<BS>\
snoremap ^ b<BS>^
snoremap ` b<BS>`
nmap gx <Plug>NetrwBrowseX
snoremap <Left> bi
snoremap <Right> a
snoremap <BS> b<BS>
snoremap <silent> <S-Tab> i<Right>=BackwardsSnippet()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
map <S-Insert> <MiddleMouse>
inoremap <silent> 	 =TriggerSnippet()
inoremap <silent> 	 =ShowAvailableSnips()
let &cpo=s:cpo_save
unlet s:cpo_save
set background=dark
set backspace=indent,eol,start
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set history=50
set hlsearch
set nomodeline
set mouse=a
set printoptions=paper:letter
set ruler
set runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim72,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after
set scrolloff=1
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set termencoding=utf-8
set textwidth=207
set window=55
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +0 Railsapps/ffflourish/features/user_posts_manage.feature
badd +13 NERD_tree_1
badd +0 Dropbox/LCRB/05_Railsapps/ffflourish/app/controllers/comments_controller.rb
badd +0 Dropbox/LCRB/05_Railsapps/ffflourish/app/controllers/stats_controller.rb
silent! argdel *
edit Dropbox/LCRB/05_Railsapps/ffflourish/app/controllers/stats_controller.rb
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 27 + 28) / 56)
exe 'vert 1resize ' . ((&columns * 92 + 102) / 205)
exe '2resize ' . ((&lines * 26 + 28) / 56)
exe 'vert 2resize ' . ((&columns * 92 + 102) / 205)
exe 'vert 3resize ' . ((&columns * 112 + 102) / 205)
argglobal
let s:cpo_save=&cpo
set cpo&vim
nmap <buffer> gf <Plug>RailsTabFind
nmap <buffer> f <Plug>RailsSplitFind
nmap <buffer> [f <Plug>RailsAlternate
nmap <buffer> ]f <Plug>RailsRelated
nmap <buffer> gf <Plug>RailsFind
nnoremap <buffer> <silent> <Plug>RailsTabFind :RTfind
nnoremap <buffer> <silent> <Plug>RailsVSplitFind :RVfind
nnoremap <buffer> <silent> <Plug>RailsSplitFind :RSfind
nnoremap <buffer> <silent> <Plug>RailsFind :REfind
nnoremap <buffer> <silent> <Plug>RailsRelated :R
nnoremap <buffer> <silent> <Plug>RailsAlternate :A
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal completefunc=syntaxcomplete#Complete
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=^\\s*def\\s\\+\\(self\\.\\)\\=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'ruby'
setlocal filetype=ruby
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcq
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=RailsIncludeexpr()
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal nomodeline
setlocal modifiable
setlocal nrformats=octal,hex
setlocal nonumber
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=.,~/Dropbox/LCRB/05_Railsapps/ffflourish,~/Dropbox/LCRB/05_Railsapps/ffflourish/app,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/models,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/controllers,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/helpers,~/Dropbox/LCRB/05_Railsapps/ffflourish/config,~/Dropbox/LCRB/05_Railsapps/ffflourish/lib,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/views,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/views/stats,~/Dropbox/LCRB/05_Railsapps/ffflourish/public,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/models,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/controllers,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/helpers,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/views,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/lib,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/requests,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/integration,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/*,~/Dropbox/LCRB/05_Railsapps/ffflourish/vendor,~/Dropbox/LCRB/05_Railsapps/ffflourish/vendor/plugins/*/lib,~/Dropbox/LCRB/05_Railsapps/ffflourish/vendor/plugins/*/test,~/Dropbox/LCRB/05_Railsapps/ffflourish/vendor/rails/*/lib,~/Dropbox/LCRB/05_Railsapps/ffflourish/vendor/rails/*/test,/usr/include,
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%<%f\ %h%m%r%{rails#statusline()}%=%-14.(%l,%c%V%)\ %P
setlocal suffixesadd=.rb,.rhtml,.erb,.rxml,.builder,.rjs,.mab,.liquid,.haml,.dryml,.mn,.yml,.csv,.rake,s.rb
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'ruby'
setlocal syntax=ruby
endif
setlocal tabstop=8
setlocal tags=~/Dropbox/LCRB/05_Railsapps/ffflourish/tmp/tags,./tags,./TAGS,tags,TAGS,~/Dropbox/LCRB/05_Railsapps/ffflourish/tags
setlocal textwidth=207
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 25 - ((24 * winheight(0) + 13) / 27)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
25
normal! 072l
wincmd w
argglobal
edit Dropbox/LCRB/05_Railsapps/ffflourish/app/controllers/comments_controller.rb
let s:cpo_save=&cpo
set cpo&vim
nmap <buffer> gf <Plug>RailsTabFind
nmap <buffer> f <Plug>RailsSplitFind
nmap <buffer> [f <Plug>RailsAlternate
nmap <buffer> ]f <Plug>RailsRelated
nmap <buffer> gf <Plug>RailsFind
nnoremap <buffer> <silent> <Plug>RailsTabFind :RTfind
nnoremap <buffer> <silent> <Plug>RailsVSplitFind :RVfind
nnoremap <buffer> <silent> <Plug>RailsSplitFind :RSfind
nnoremap <buffer> <silent> <Plug>RailsFind :REfind
nnoremap <buffer> <silent> <Plug>RailsRelated :R
nnoremap <buffer> <silent> <Plug>RailsAlternate :A
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal completefunc=syntaxcomplete#Complete
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=^\\s*def\\s\\+\\(self\\.\\)\\=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'ruby'
setlocal filetype=ruby
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcq
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=RailsIncludeexpr()
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal nomodeline
setlocal modifiable
setlocal nrformats=octal,hex
setlocal nonumber
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=.,~/Dropbox/LCRB/05_Railsapps/ffflourish,~/Dropbox/LCRB/05_Railsapps/ffflourish/app,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/models,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/controllers,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/helpers,~/Dropbox/LCRB/05_Railsapps/ffflourish/config,~/Dropbox/LCRB/05_Railsapps/ffflourish/lib,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/views,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/views/comments,~/Dropbox/LCRB/05_Railsapps/ffflourish/public,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/models,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/controllers,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/helpers,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/views,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/lib,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/requests,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/integration,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/*,~/Dropbox/LCRB/05_Railsapps/ffflourish/vendor,~/Dropbox/LCRB/05_Railsapps/ffflourish/vendor/plugins/*/lib,~/Dropbox/LCRB/05_Railsapps/ffflourish/vendor/plugins/*/test,~/Dropbox/LCRB/05_Railsapps/ffflourish/vendor/rails/*/lib,~/Dropbox/LCRB/05_Railsapps/ffflourish/vendor/rails/*/test,/usr/include,
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%<%f\ %h%m%r%{rails#statusline()}%=%-14.(%l,%c%V%)\ %P
setlocal suffixesadd=.rb,.rhtml,.erb,.rxml,.builder,.rjs,.mab,.liquid,.haml,.dryml,.mn,.yml,.csv,.rake,s.rb
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'ruby'
setlocal syntax=ruby
endif
setlocal tabstop=8
setlocal tags=~/Dropbox/LCRB/05_Railsapps/ffflourish/tmp/tags,./tags,./TAGS,tags,TAGS,~/Dropbox/LCRB/05_Railsapps/ffflourish/tags
setlocal textwidth=207
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
argglobal
edit Railsapps/ffflourish/features/user_posts_manage.feature
let s:cpo_save=&cpo
set cpo&vim
nmap <buffer> gf <Plug>RailsTabFind
nmap <buffer> f <Plug>RailsSplitFind
nmap <buffer> [f <Plug>RailsAlternate
nmap <buffer> ]f <Plug>RailsRelated
nmap <buffer> gf <Plug>RailsFind
nnoremap <buffer> <silent> <Plug>RailsTabFind :RTfind
nnoremap <buffer> <silent> <Plug>RailsVSplitFind :RVfind
nnoremap <buffer> <silent> <Plug>RailsSplitFind :RSfind
nnoremap <buffer> <silent> <Plug>RailsFind :REfind
nnoremap <buffer> <silent> <Plug>RailsRelated :R
nnoremap <buffer> <silent> <Plug>RailsAlternate :A
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal completefunc=
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != ''
setlocal filetype=
endif
setlocal foldcolumn=0
setlocal nofoldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcq
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=RailsIncludeexpr()
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal nomodeline
setlocal modifiable
setlocal nrformats=octal,hex
setlocal nonumber
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=.,~/Dropbox/LCRB/05_Railsapps/ffflourish,~/Dropbox/LCRB/05_Railsapps/ffflourish/app,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/models,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/controllers,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/helpers,~/Dropbox/LCRB/05_Railsapps/ffflourish/config,~/Dropbox/LCRB/05_Railsapps/ffflourish/lib,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/views,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/models,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/controllers,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/helpers,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/views,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/lib,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/requests,~/Dropbox/LCRB/05_Railsapps/ffflourish/spec/integration,~/Dropbox/LCRB/05_Railsapps/ffflourish/app/*,~/Dropbox/LCRB/05_Railsapps/ffflourish/vendor,~/Dropbox/LCRB/05_Railsapps/ffflourish/vendor/plugins/*/lib,~/Dropbox/LCRB/05_Railsapps/ffflourish/vendor/plugins/*/test,~/Dropbox/LCRB/05_Railsapps/ffflourish/vendor/rails/*/lib,~/Dropbox/LCRB/05_Railsapps/ffflourish/vendor/rails/*/test,/usr/include,
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=8
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%<%f\ %h%m%r%{rails#statusline()}%=%-14.(%l,%c%V%)\ %P
setlocal suffixesadd=.rb,.rhtml,.erb,.rxml,.builder,.rjs,.mab,.liquid,.haml,.dryml,.mn,.css,.js,.yml,.csv,.rake,.sql,.html,.xml
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != ''
setlocal syntax=
endif
setlocal tabstop=8
setlocal tags=~/Dropbox/LCRB/05_Railsapps/ffflourish/tmp/tags,./tags,./TAGS,tags,TAGS,~/Dropbox/LCRB/05_Railsapps/ffflourish/tags
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 24 - ((23 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
24
normal! 012l
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 27 + 28) / 56)
exe 'vert 1resize ' . ((&columns * 92 + 102) / 205)
exe '2resize ' . ((&lines * 26 + 28) / 56)
exe 'vert 2resize ' . ((&columns * 92 + 102) / 205)
exe 'vert 3resize ' . ((&columns * 112 + 102) / 205)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
