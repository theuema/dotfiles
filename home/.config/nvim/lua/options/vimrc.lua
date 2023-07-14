-- .vimrc settings
vim.cmd([[
  " --- Move a line of text up/down using ALT+[jk], indent with ALT+[hl] 
  nnoremap <A-j> :m+<CR>==
  nnoremap <A-k> :m-2<CR>==
  nnoremap <A-h> <<
  nnoremap <A-l> >>
  inoremap <A-j> <Esc>:m+<CR>==gi
  inoremap <A-k> <Esc>:m-2<CR>==gi
  inoremap <A-h> <Esc><<`]a
  inoremap <A-l> <Esc>>>`]a
  vnoremap <A-j> :m'>+<CR>gv=gv
  vnoremap <A-k> :m-2<CR>gv=gv
  vnoremap <A-h> <gv
  vnoremap <A-l> >gv
  " --- Use :bonly to delete every buffer execpt the current 
  command Bonly silent! execute "%bd|e#|bd#"
]])
