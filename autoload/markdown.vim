"section   section
"-------   =======
"
"# section
let s:markdown_section_type = [
    \ '^.*\n^[-=]+$',
    \ '^#+[ \t].*$'
\ ]

function! markdown#next_section(backward, visual)
  " restore the select region, because execute command will leave visual mode
  if a:visual
      normal! gv
  endif

  let dir = a:backward ? '?' : '/'
  let pattern = '\v' . join(s:markdown_section_type, '|')
  let cmd = printf("silent normal! %s%s\<CR>", dir, pattern)

  execute cmd
endfunction
" vim:set sw=2:
