
autocmd User VimagitEnterCommit startinsert

nnoremap <silent> <Leader>gg :Magit<CR>

autocmd User VimagitEnterCommit startinsert

nnoremap <silent> <Leader>ga :Git add %:p<CR>
nnoremap <silent> <Leader>gd :Gdiffsplit<CR>
nnoremap <silent> <Leader>gc :Git commit<CR>
nnoremap <silent> <Leader>gb :Git blame<CR>
nnoremap <silent> <Leader>gf :Gfetch<CR>
nnoremap <silent> <Leader>gs :Git<CR>
nnoremap <silent> <Leader>gp :Gpush<CR>

autocmd User VimagitEnterCommit startinsert
