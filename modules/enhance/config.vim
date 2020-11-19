
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
