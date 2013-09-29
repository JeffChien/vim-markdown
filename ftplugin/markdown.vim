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

noremap <script> <buffer> <silent> ]]
      \ :call markdown#next_section(0, 0)<cr>
noremap <script> <buffer> <silent> ]]
      \ :call markdown#next_section(0, 0)<cr>
vnoremap <script> <buffer> <silent> [[
      \ :call markdown#next_section(1, 1)<cr>
vnoremap <script> <buffer> <silent> ]]
      \ :call markdown#next_section(0, 1)<cr>


" vim:set sw=2:
