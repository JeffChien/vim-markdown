" Vim filetype plugin
" Language:		Markdown
" Maintainer:		Tim Pope <vimNOSPAM@tpope.org>

if exists("b:did_ftplugin")
  finish
endif

runtime! ftplugin/html.vim ftplugin/html_*.vim ftplugin/html/*.vim

setlocal comments=fb:*,fb:-,fb:+,n:> commentstring=>\ %s
setlocal formatoptions+=tcqln formatoptions-=r formatoptions-=o
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= "|setl cms< com< fo< flp<"
else
  let b:undo_ftplugin = "setl cms< com< fo< flp<"
endif

let s:markdown_ctags = expand('<sfile>:p:h:h') . '/ctags/markdown.cnf'

" tagbar support, since 'loaded_tagbar' variable is set in autoload,
" there is no way to detect if tabar is exist or not
let g:tagbar_type_markdown = {
	  \ 'ctagstype' : 'markdown',
	  \ 'kinds' : [
	  \   'h:Heading_L1',
	  \   'i:Heading_L2',
	  \   'k:Heading_L3',
	  \ ],
	  \ 'sort' : 0,
	  \ 'deffile' : s:markdown_ctags,
  \ }

" ctrlp
if exists('loaded_ctrlp')
  let g:ctrlp_buftag_types = {
        \ 'markdown' : '--options=' . s:markdown_ctags,
    \ }
endif
" vim:set sw=2:
