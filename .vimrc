scriptencoding utf-8
" ^^ Please leave the above line at the start of the file.

" Based on the Gentoo vimrc script (/etc/vim/vimrc)

" {{{ General settings
" The following are some sensible defaults for Vim for most users.
" We attempt to change as little as possible from Vim's defaults,
" deviating only where it makes sense
set nocompatible        " Use Vim defaults (much better!)
set bs=2                " Allow backspacing over everything in insert mode
set ai                  " Always set auto-indenting on
set history=50          " keep 50 lines of command history
set ruler               " Show the cursor position all the time

set viminfo='20,\"500   " Keep a .viminfo file.

" Don't use Ex mode, use Q for formatting
map Q gq

" When doing tab completion, give the following files lower priority. You may
" wish to set 'wildignore' to completely ignore files, and 'wildmenu' to enable
" enhanced tab completion. These can be done in the user vimrc file.
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out

" When displaying line numbers, don't use an annoyingly wide number column. This
" doesn't enable line numbers -- :set number will do that. The value given is a
" minimum width to use for the number column, not a fixed size.
if v:version >= 700
  set numberwidth=3
endif
" }}}

" {{{ Modeline settings
" We don't allow modelines by default. See bug #14088 and bug #73715.
" If you're not concerned about these, you can enable them on a per-user
" basis by adding "set modeline" to your ~/.vimrc file.
set nomodeline
" }}}

" {{{ Locale settings
" Try to come up with some nice sane GUI fonts. Also try to set a sensible
" value for fileencodings based upon locale. These can all be overridden in
" the user vimrc file.
if v:lang =~? "^ko"
  set fileencodings=euc-kr
  set guifontset=-*-*-medium-r-normal--16-*-*-*-*-*-*-*
elseif v:lang =~? "^ja_JP"
  set fileencodings=euc-jp
  set guifontset=-misc-fixed-medium-r-normal--14-*-*-*-*-*-*-*
elseif v:lang =~? "^zh_TW"
  set fileencodings=big5
  set guifontset=-sony-fixed-medium-r-normal--16-150-75-75-c-80-iso8859-1,-taipei-fixed-medium-r-normal--16-150-75-75-c-160-big5-0
elseif v:lang =~? "^zh_CN"
  set fileencodings=gb2312
  set guifontset=*-r-*
endif

" If we have a BOM, always honour that rather than trying to guess.
if &fileencodings !~? "ucs-bom"
  set fileencodings^=ucs-bom
endif

" Always check for UTF-8 when trying to determine encodings.
if &fileencodings !~? "utf-8"
  set fileencodings+=utf-8
endif

" Make sure we have a sane fallback for encoding detection
set fileencodings+=default
" }}}

" {{{ Syntax highlighting settings
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
" }}}

" {{{ Terminal fixes
if &term ==? "xterm"
  " Previously we would unset t_RV to prevent gnome-terminal from beeping as
  " vim started.  These days it appears that gnome-terminal has been repaired,
  " so re-enable this, and don't restrict t_Co=8.  (21 Jun 2004 agriffis)
  "set t_RV=			" don't check terminal version
  "set t_Co=8
  set t_Sb=^[4%dm
  set t_Sf=^[3%dm
  set ttymouse=xterm2	" only works for >=xfree86-3.3.3, should be okay
endif
" }}}

" {{{ Filetype plugin settings
" Enable plugin-provided filetype settings, but only if the ftplugin
" directory exists (which it won't on livecds, for example).
if isdirectory(expand("$VIMRUNTIME/ftplugin"))
  filetype plugin on

  " Uncomment the next line (or copy to your ~/.vimrc) for plugin-provided
  " indent settings. Some people don't like these, so we won't turn them on by
  " default.
  " filetype indent on
endif
" }}}

" {{{ Autocommands
if has("autocmd")

augroup gentoo
  au!

  " Gentoo-specific settings for ebuilds.  These are the federally-mandated
  " required tab settings.  See the following for more information:
  " http://www.gentoo.org/proj/en/devrel/handbook/handbook.xml
  " Note that the rules below are very minimal and don't cover everything.
  " Better to emerge app-vim/gentoo-syntax, which provides full syntax,
  " filetype and indent settings for all things Gentoo.
  au BufRead,BufNewFile *.e{build,class} let is_bash=1|setfiletype sh
  au BufRead,BufNewFile *.e{build,class} set ts=4 sw=4 noexpandtab

  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
        \ if ! exists("g:leave_my_cursor_position_alone") |
        \     if line("'\"") > 0 && line ("'\"") <= line("$") |
        \         exe "normal g'\"" |
        \     endif |
        \ endif

  " When editing a crontab file, set backupcopy to yes rather than auto. See
  " :help crontab and bug #53437.
  autocmd FileType crontab set backupcopy=yes
    " autocmd! BufNewFile,BufReadPre,FileReadPre  *.hs  set tabstop=4
augroup END

endif " has("autocmd")
" }}}

"END OF GENTOO STUFF

"From omnicppcomplete
set nocp
filetype plugin on

" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
" build tags of your own project with CTRL+F12
map <C-F12> :!ctags -R --c++-kinds=+pl --fields=+iaSn --extra=+q .<CR>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" Cut / copy / paste like in Windows
map <C-c> "+y
map <C-x> "+x
map <C-v> "+gP
" Paste to the end of the line
map <S-C-p> a<SPACE><ESC>"+gP$x


"These paste commands were gotten from mswin.vim (on the Internet)
" Use Shift-Insert as paste in Insert mode
" cmap <S-Insert>		<C-R>+
imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>


" Select all
map <C-a> ggvG$

" Save
map <C-s> :w<CR>

" Open HTML files in a text editor
function PreviewHTML_External()
  "exe "silent !firefox \"(file://" . expand( "%:p" ) . ")\""
	exe "silent !firefox \"" . "%:p" . "\""
endfunction
map <F3> :call PreviewHTML_External()<CR>

" Remove toolbar
set guioptions-=T

" vim: set fenc=utf-8 tw=80 sw=2 sts=2 et foldmethod=marker :
set mouse=a
set is
set hidden
set shiftwidth=4
set autoread
set nohlsearch
set textwidth=0
set wm=0
set tabstop=4
set expandtab
:filetype on
:autocmd FileType c,cpp :set cindent
map <F5> :make<Return>
map <F6> :cnext<Return>
map <S-F6> :cprevious<Return>
:autocmd FileType tex :set list
map <A-F4> :q<Return>

" Put swap recovery files in a special directory, rather than cluttering up
" each directory.
set directory=~/.vim/swap

" Use this so that paste works in insert mode
source $VIMRUNTIME/mswin.vim
behave mswin

" Default to not read-only in vimdiff
set noro

