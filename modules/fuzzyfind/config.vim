
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
"nnoremap <silent> <Leader>,   :Clap coc_commands<CR>
" Search workspace symbols
nnoremap <silent> <Leader>cs  :Clap coc_symbols<CR>
nnoremap <silent> <Leader>cS  :Clap coc_services<CR>
nnoremap <silent> <leader>ct  :Clap coc_outline<CR>

"--------------------------"
"      fzf Keymap          "
"--------------------------"
"
let g:fzf_history_dir = '~/.local/share/fzf-history'

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
"ag only content without file name
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
command! -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 2..'}))

nnoremap <silent> <Space>k<Space> :Files<CR>
nnoremap <silent> <Space>gf<Space> :GFiles<CR>
nnoremap <silent> <Space>h<Space> :History<CR>
nnoremap <silent> <Space><Space> :Buffers<CR>
nnoremap <silent> <Space>ag<Space> :Ag<CR>
nnoremap <silent> <Space>rg<Space> :RG<CR>
nnoremap <silent> <Space>l<Space> :Lines<CR>
nnoremap <silent> <Space>t<Space> :BTags<CR>
"
nnoremap <silent> <Space>m<Space> :History:<CR>
nnoremap <silent> <Space>n<Space> :History/<CR>
nnoremap <silent> <C-Space> :call fzf#run(fzf#wrap({'source': 'find $HOME/development -maxdepth 1 -type d', 'sink': 'Files'}))<CR>
" The query history for this command will be stored as 'ls' inside g:fzf_history_dir.
" The name is ignored if g:fzf_history_dir is not defined.
command! -bang -complete=dir -nargs=? LS
    \ call fzf#run(fzf#wrap('ls', {'source': 'ls', 'dir': <q-args>}, <bang>0))


"https://github.com/junegunn/fzf.vim/issues/27
"
" "Raw" version of ag; arguments directly passed to ag
"
" e.g.
"   " Search 'foo bar' in ~/projects
"   :Ag "foo bar" ~/projects
"
"   " Start in fullscreen mode
"   :Ag! "foo bar"
"command! -bang -nargs=+ -complete=file Ag call fzf#vim#ag_raw(<q-args>, <bang>0)
command! -bang -nargs=+ -complete=file AgRaw call fzf#vim#ag_raw(<q-args>, fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)


"https://github.com/junegunn/fzf.vim/issues/346
"
" AgIn: Start ag in the specified directory
"
" e.g.
"   :AgIn .. foo
function! s:ag_in(bang, ...)
  if !isdirectory(a:1)
    throw 'not a valid directory: ' .. a:1
  endif
  " Press `?' to enable preview window.
  call fzf#vim#ag(join(a:000[1:], ' '), fzf#vim#with_preview({'dir': a:1, 'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'), a:bang)

  " If you don't want preview option, use this
  " call fzf#vim#ag(join(a:000[1:], ' '), {'dir': a:1}, a:bang)
endfunction

command! -bang -nargs=+ -complete=dir AgIn call s:ag_in(<bang>0, <f-args>)
nnoremap <silent> <Space>agi<Space> :call fzf#run(fzf#wrap({'source': 'find $HOME/development -maxdepth 1 -type d', 'sink': 'AgIn'}))<CR>


function! s:fzf_neighbouring_files(bang)
  let current_file =expand("%")
  let cwd = fnamemodify(current_file, ':p:h')
  let command = 'ag -g "" -f ' . cwd . ' --depth 0'

  call fzf#run(fzf#wrap({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '-m -x +s',
        \ 'down': '20%'
        \  }))
endfunction

command! -bang -nargs=* -complete=file FZFNeigh call s:fzf_neighbouring_files(<bang>0)
nnoremap <silent> <Space>na<Space> :FZFNeigh<CR>

nnoremap <silent> <Space>j<Space> :call fzf#run(fzf#wrap({'source': 'find $HOME -maxdepth 2 -type d', 'sink': 'cd'}))<CR>

"Usage: ':e <c-x><c-d> enter  -- select dir -- back to command mode
function! s:append_dir_with_fzf(line)
  call fzf#run(fzf#wrap({
    \ 'options': ['--prompt', a:line.'> '],
    \ 'source': 'find . -type d',
    \ 'sink': {line -> feedkeys("\<esc>:".a:line.line, 'n')}}))
  return ''
endfunction

cnoremap <expr> <c-x><c-d> <sid>append_dir_with_fzf(getcmdline())
"--------------------------"
"     vim-fzf Keymap      "
"--------------------------"
"
let g:coc_fzf_preview = ''
let g:coc_fzf_opts = []
nnoremap <silent> <Space>y<Space> :CocFzfList yank<CR>
