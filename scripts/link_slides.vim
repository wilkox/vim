function! link_slides#link_slides()

  " Get the title of the current note and construct a move-to path
  let title = link_slides#get_title()
  let moveToPath = expand("~/lecture_slides/" . title . ".pdf")
  echom "Move to path is " . moveToPath

  " Locate the most recent .pdf or .ppt downloaded
  let slides = system("ls -t ~/Downloads | grep \'pdf\\|ppt\' | head -1")
  let slides = substitute(slides, '\n\+$', '', '')
  let slides = expand("~/Downloads/" . slides)
  " TODO handle .ppt conversion
  echom "Move from path is " . slides

  let confirm = "Found " . recentDownload . ", ready to link? (Y/n)"
  echomsg confirm
  let confirmation = nr2char(getchar())
  echomsg "Confirmation is " . confirmation
  if confirmation == "y"
    let renameResult = rename(slides, moveToPath)
    if renameResult != 0
      echom "Move failed (unknown reason)"
    endif
  endif
endfunction
