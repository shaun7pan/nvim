
let s:profile = expand($HOME . '/.profile')
let s:tmux_conf = expand($HOME . '/.tmux.conf')
let s:vmap_conf = expand($HOME . '/.config/nvim/core/vmap.vim')
let s:clap_conf = expand($HOME . '/.config/nvim/modules/fuzzyfind/config.vim')
let g:clap_cache_directory = $DATA_PATH . '/clap'
let g:clap_theme = 'material_design_dark'
let g:clap_current_selection_sign= { 'text': '➤', 'texthl': "ClapCurrentSelectionSign", "linehl": "ClapCurrentSelection"}
let g:clap_layout = { 'relative': 'editor' }
let g:clap_enable_icon = 1
let g:clap_search_box_border_style = 'curve'
let g:clap_provider_grep_enable_icon = 1
let g:clap_prompt_format = '%spinner%%forerunner_status% %provider_id%: '
let g:clap_provider_personalconf = {
      \ 'source': [s:profile,s:tmux_conf,s:vmap_conf,s:clap_conf],
      \ 'sink': 'e',
      \ }

" A funtion to config highlight of ClapSymbol
" when the background color is opactiy
function! s:ClapSymbolHL() abort
    let s:current_bgcolor = synIDattr(hlID("Normal"), "bg")
    if s:current_bgcolor == ''
        hi ClapSymbol guibg=NONE ctermbg=NONE
    endif
endfunction

autocmd User ClapOnEnter call s:ClapSymbolHL()

"--------------------------"
"     vim-clap Keymap      "
"--------------------------"
nnoremap <silent> <Leader>tc :<C-u>Clap colors<CR>
nnoremap <silent> <Leader>bb :<C-u>Clap marks<CR>
"like emacs counsel-find-file
nnoremap <silent> <Leader>fa :<C-u>Clap grep2<CR>
nnoremap <silent> <Leader>fb :<C-u>Clap buffers<CR>
nnoremap <silent> <Leader>fd :<C-u>Clap filer<CR>
nnoremap <silent> <Leader>ff :<C-u>Clap files ++finder=rg --ignore --hidden --files<cr>
nnoremap <silent> <Leader>fg :<C-u>Clap gfiles<CR>
nnoremap <silent> <Leader>fw :<C-u>Clap grep ++query=<cword><cr>
nnoremap <silent> <Leader>fh :<C-u>Clap history<CR>
nnoremap <silent> <Leader>fW :<C-u>Clap windows<CR>
nnoremap <silent> <Leader>fl :<C-u>Clap loclist<CR>
nnoremap <silent> <Leader>fu :<C-u>Clap git_diff_files<CR>
nnoremap <silent> <Leader>fv :<C-u>Clap grep ++query=@visual<CR>
nnoremap <silent> <Leader>oc :<C-u>Clap personalconf<CR>

"--------------------------"
"     coc-clap Keymap      "
"--------------------------"
" Show all diagnostics
nnoremap <silent> <Leader>ce  :Clap coc_diagnostics<CR>
" Manage extensions
nnoremap <silent> <Leader>;   :Clap coc_extensions<CR>
" Show commands
nnoremap <silent> <Leader>,   :Clap coc_commands<CR>
" Search workspace symbols
nnoremap <silent> <Leader>cs  :Clap coc_symbols<CR>
nnoremap <silent> <Leader>cS  :Clap coc_services<CR>
nnoremap <silent> <leader>ct  :Clap coc_outline<CR>

"--------------------------"
"      fzf Keymap          "
"--------------------------"

"function! s:find_git_root()
"  return system('git rev-parse --show-toplevel -1> /dev/null')[:-2]
"endfunction
"
"command! ProjectFiles execute 'Files' s:find_git_root()
"
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nnoremap <silent> <C-x><C-f> :Files<CR>
nnoremap <silent> <C-x><C-h> :History<CR>
nnoremap <silent> <C-x><C-b> :Buffers<CR>
nnoremap <silent> <C-x><C-a> :Ag<CR>
nnoremap <silent> <C-x><C-r> :RG<CR>
nnoremap <silent> <C-x><C-l> :Lines<CR>
nnoremap <silent> <C-x><C-t> :BTags<CR>
"
nnoremap <silent> <C-x><C-m> :History:<CR>
nnoremap <silent> <C-x><C-n> :History/<CR>
nnoremap <silent> <C-Space> :call fzf#run(fzf#wrap({'source': 'find $HOME/development -maxdepth 1 -type d', 'sink': 'Files'}))<CR>
