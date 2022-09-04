" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk
" I like using H and L for beginning/end of line
nmap H ^
nmap L $
" Quickly remove search highlights
nmap <F9> :nohl
imap jj <Esc>

" Yank to system clipboard
set clipboard=unnamed

" Go back and forward with Ctrl+U and Ctrl+D
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
noremap <C-u> :back
exmap forward obcommand app:go-forward
noremap <C-d> :forward
