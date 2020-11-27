" open vimrc and edit
nnoremap <LEADER>vi :e $MYVIMRC<CR>
map R :source $MYVIMRC <CR>
map E $
map B ^
nnoremap <leader>w :bd<CR>
" map jk to ESC
inoremap jk <Esc>
" See plugin/bufkill.vim
" use emacs keybind
nmap <C-x>k :BD<CR>
"Write buffer (save)
nnoremap <C-S> :<C-u>write<CR>
nnoremap <C-Q> :q!<CR>
"yank to end
nnoremap Y y$
" Whitespace jump (see plugin/whitespace.vim)
nnoremap ]w :<C-u>WhitespaceNext<CR>
nnoremap [w :<C-u>WhitespacePrev<CR>
" Remove spaces at the end of lines
nnoremap <silent> <Space>cw :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" insert keymap like emacs
"inoremap <C-w> <C-[>diwa
inoremap <C-h> <BS>
inoremap <C-d> <Del>
inoremap <C-k>  <ESC>d$a
inoremap <C-u> <C-G>u<C-U>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
"inoremap <C-a> <ESC>^i
inoremap <expr><C-e> pumvisible() ? "\<C-e>" : "\<End>"
"insert a newline
inoremap <C-O> <Esc>o
imap <C-S> <esc>:w<CR>
imap <C-Q> <esc>:wq<CR>

" command line alias
cnoremap <C-p> <Up>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>
cnoremap <C-t> <C-R>=expand("%:p:h") . "/" <CR>

tnoremap <A-[> <C-\><C-n>

function! s:QuiteVim() abort
  if empty(expand('%:t'))
    execute ":q"
  else
    execute ":wq!"
  endif
endfunction
" Quiet
nnoremap <leader>qq :call <SID>QuiteVim()<CR>
nnoremap <leader>qw <esc>:q!<CR>

"switch window
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" settings for resize splitted window
nmap <C-w>[ :vertical resize -3<CR>
nmap <C-w>] :vertical resize +3<CR>

" Session management shortcuts (see plugin/sessions.vim)
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>


"map <Up> :resize+5 <CR>
"map <Down> :resize-5 <CR>
map <Left> :vertical resize-5 <CR>
map <Right> :vertical resize+5 <CR>

map sl :set splitright <CR> :vsplit <CR>
map sh :set nosplitright <CR> :vsplit <CR>
map sj :set splitbelow <CR> :split <CR>
map sk :set nosplitbelow <CR> :split <CR>

map tn :tabe <CR>
map th :-tabnext <CR>
map tl :+tabnext <CR>

" Make vim help in new tab
" Only apply to .txt files as help files will always be txt files
augroup HelpInTabs
    autocmd!
    autocmd BufEnter *.txt  call HelpInNewTab()
augroup END

" Only apply to .txt files...
function! HelpInNewTab ()
    if &buftype == 'help'
        " Convert the help window to a tab...
        execute "normal \<C-W>T"
    endif
endfunction


nnoremap gb :ls<CR>:b<Space>
