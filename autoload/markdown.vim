"section   section
"-------   =======
"
"# section
let s:markdown_section_type = [
    \ '^.*\n^[-=]+$',
    \ '^#+[ \t].*$'
\ ]

"normal link [descript](link) and image link ![alt](path)
let s:markdown_link = '\v!=[(.{-})\]\((.{-})\)'
"reference link [desk][id]
let s:markdown_reflink = '\v!=[(.{-})\]\[(.{-})\]'

let s:idstack = []

function! markdown#PopId()
  if len(s:idstack) > 0
    let pos = remove(s:idstack, -1)
    call setpos('.', pos)
  else
    echom "stack is empty"
  endif
endfunction

function! markdown#JumpId(id)
  call add(s:idstack, getpos('.'))
  let pattern = printf('\v\[%s\]: .*$', a:id)
  let spos = searchpos(pattern, 'w')
  if spos[0] != 0 && spos[1] != 0
    call cursor(spos)
  endif
endfunction

function! markdown#GotoIdOpenLink()
  " try
  let text = markdown#CursorText(s:markdown_link)
  if text != ""
    let groups = matchlist(text, s:markdown_link)
    let descript = groups[1]
    let link = groups[2]
    " TODO open link, new buffer or open by browser, depend on link
    " if path not exist, prompt if create or not
    return
  endif

  " try
  let text = markdown#CursorText(s:markdown_reflink)
  if text != ""
    let groups = matchlist(text, s:markdown_reflink)
    let descript = groups[1]
    let id = groups[2] != "" ? groups[2] : descript
    call markdown#JumpId(id)
    return
  endif
endfunction

function! markdown#CursorText(pattern)
  let cursor = col('.') - 1
  let line = getline('.')
  let sbegin = 0
  let send = 0
  let i = cursor
  while (i > -1)
    let sbegin = match(line, a:pattern, i)
    let send = matchend(line, a:pattern, i)
    if cursor >= sbegin && cursor < send
      break
    endif
    let i -= 1
  endwhile

  return (sbegin > -1) ? strpart(line, sbegin, send-sbegin) : ""
endfunction

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

function! markdown#next_link(backward)
  " move cursor to the next or previous link
  let dir = a:backward ? '?' : '/'
  let pattern = s:markdown_link . '|' . s:markdown_reflink
  let cmd = printf("silent normal! %s%s\<CR>", dir, pattern)

  execute cmd
endfunction
" vim:set sw=2:
