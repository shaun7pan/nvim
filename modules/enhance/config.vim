
"accelerated-jk
nmap <silent>j <Plug>(accelerated_jk_gj)
nmap <silent>k <Plug>(accelerated_jk_gk)

nnoremap <silent> <Leader>m :MundoToggle<CR>

" Easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_prompt = 'Jump to → '
let g:EasyMotion_keys = 'fjdkswbeoavn'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

nmap gsj <Plug>(easymotion-w)
nmap gsk <Plug>(easymotion-b)
nmap gsf <Plug>(easymotion-overwin-f)

" Rainbow
let g:rainbow_active = 1

nnoremap <silent> <Leader>t :<C-u>FloatermToggle<CR>

" Configuration example
"let g:floaterm_keymap_new    = '<F7>'
"let g:floaterm_keymap_prev   = '<F8>'
"let g:floaterm_keymap_next   = '<F9>'
"let g:floaterm_keymap_toggle = '<F12>'

"let g:floaterm_gitcommit = 'vsplit'
"
"
"nnoremap   <silent>   <F7>    :FloatermPrev<CR>
"tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermPrev<CR>
"nnoremap   <silent>   <F8>    :FloatermNew! source ~/.profile<CR>
"tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermNew! source ~/.profile<CR>
"nnoremap   <silent>   <F9>    :FloatermNext<CR>
"tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
"nnoremap   <silent>   <F12>   :FloatermToggle<CR>
"tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>
