if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufNewFile,BufRead *.csv setf csv
  au! BufNewFile,BufRead *.R  setf r
augroup END

" Tidy files
au! BufNewFile,BufRead *.tidy.txt setf tidy
