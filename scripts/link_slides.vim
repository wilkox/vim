function! link_slides#link_slides()

  " Get the title of the current note and construct a move-to path
  let title = getline(1)
  let moveToPath = expand("~/lecture_slides/" . title . ".pdf")

  " Locate the most recent .pdf or .ppt downloaded
  let slides = system("ls -t ~/Downloads | grep \'pdf\\|ppt\' | head -1")
  let slides = substitute(slides, '\n\+$', '', '')
  let slides = expand("~/Downloads/" . slides)
  " TODO handle .ppt conversion

  " Confirm and move
  echomsg "Found " . slides . ", ready to link? (y/n)"
  let confirmation = nr2char(getchar())
  if confirmation == "y"
    let renameResult = rename(slides, moveToPath)
    if renameResult != 0
      echom "Move failed"
    else
      echom "Done"
    endif
  endif

endfunction

function! link_slides#open_slides()

  " Get the title of the current note and construct a path for the slides
  let title = getline(1)
  let slides = expand("~/lecture_slides/" . title . ".pdf")

  " Test if file exists
  if empty(glob(slides))
    echom "Slides not found at " . slides
    return
  endif

  " Open slides
  call system("open " . shellescape(slides))

endfunction
