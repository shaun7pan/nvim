
"--------------------------"
"     vim-buffet Keymap    "
"--------------------------"
nnoremap  [b :<C-u>bp<CR>
nnoremap  ]b :<C-u>bn<CR>
nnoremap <silent> <Space>bo<Space> :Bonly<CR>
nnoremap <silent> <Space>bw<Space> :Bw<CR>
nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)

let g:buffet_always_show_tabline = 1
let g:buffet_powerline_separators = 1
let g:buffet_use_devicons = 1
let g:buffet_show_index = 1

"spaceline
let g:spaceline_seperate_style = 'slant'

"defx
call defx#custom#option('_', {
  \ 'resume': 1,
  \ 'winwidth': 30,
  \ 'split': 'vertical',
  \ 'direction': 'topleft',
  \ 'show_ignored_files': 0,
  \ 'columns': 'indent:git:icons:filename',
  \ 'root_marker': ' ',
  \ 'floating_preview': 1,
  \ 'vertical_preview': 1,
  \ 'preview_height': 50,
  \ })

call defx#custom#column('git', {
  \   'indicators': {
  \     'Modified'  : '•',
  \     'Staged'    : '✚',
  \     'Untracked' : 'ᵁ',
  \     'Renamed'   : '≫',
  \     'Unmerged'  : '≠',
  \     'Ignored'   : 'ⁱ',
  \     'Deleted'   : '✖',
  \     'Unknown'   : '⁇'
  \   }
  \ })

call defx#custom#column('mark', { 'readonly_icon': '', 'selected_icon': '' })

" Events
" ---

augroup user_plugin_defx
  autocmd!

  " Define defx window mappings
  autocmd FileType defx call <SID>defx_mappings()

  " Delete defx if it's the only buffer left in the window
  autocmd WinEnter * if &filetype == 'defx' && winnr('$') == 1 | bdel | endif

  " Move focus to the next window if current buffer is defx
  autocmd TabLeave * if &filetype == 'defx' | wincmd w | endif

augroup END


" Internal functions
" ---
function! s:jump_dirty(dir) abort
  " Jump to the next position with defx-git dirty symbols
  let l:icons = get(g:, 'defx_git_indicators', {})
  let l:icons_pattern = join(values(l:icons), '\|')

  if ! empty(l:icons_pattern)
    let l:direction = a:dir > 0 ? 'w' : 'bw'
    return search(printf('\(%s\)', l:icons_pattern), l:direction)
  endif
endfunction

function! s:defx_toggle_tree() abort
  " Open current file, or toggle directory expand/collapse
  if defx#is_directory()
    return defx#do_action('open_or_close_tree')
  endif
  return defx#do_action('multi', ['drop'])
endfunction

"打开vim自动打开defx
func! ArgFunc() abort
    let s:arg = argv(0)
    if isdirectory(s:arg)
        return s:arg
    else
        return fnamemodify(s:arg, ':h')
    endif
endfunc
autocmd VimEnter * Defx `ArgFunc()` -resume -toggle -no-focus -buffer-name=tab`tabpagenr()`

function! s:defx_mappings() abort
  " Defx window keyboard mappings
  setlocal signcolumn=no expandtab

  nnoremap <silent><buffer><expr> <CR>  defx#do_action('drop')
  nnoremap <silent><buffer><expr> l     <sid>defx_toggle_tree()
  nnoremap <silent><buffer><expr> h     defx#async_action('cd', ['..'])
  nnoremap <silent><buffer><expr> st    defx#do_action('multi', [['drop', 'tabnew'], 'quit'])
  nnoremap <silent><buffer><expr> v     defx#do_action('open', 'botright vsplit')
  nnoremap <silent><buffer><expr> i     defx#do_action('open', 'botright split')
  nnoremap <silent><buffer><expr> P     defx#do_action('preview')
  nnoremap <silent><buffer><expr> K     defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N     defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> dd    defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> r     defx#do_action('rename')
  nnoremap <silent><buffer><expr> x     defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> .     defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> yy    defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> ~     defx#async_action('cd')
  nnoremap <silent><buffer><expr> q     defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Tab> winnr('$') != 1 ?
    \ ':<C-u>wincmd w<CR>' :
    \ ':<C-u>Defx -buffer-name=temp -split=vertical<CR>'
  " Defx's buffer management
  nnoremap <silent><buffer><expr> q      defx#do_action('quit')
  nnoremap <silent><buffer><expr> se     defx#do_action('save_session')
  nnoremap <silent><buffer><expr> <C-r>  defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>  defx#do_action('print')
  " File/dir management
  nnoremap <silent><buffer><expr><nowait> c  defx#do_action('copy')
  nnoremap <silent><buffer><expr><nowait> m  defx#do_action('move')
  nnoremap <silent><buffer><expr><nowait> p  defx#do_action('paste')
  nnoremap <silent><buffer><expr><nowait> r  defx#do_action('rename')
  nnoremap <silent><buffer><expr> dd defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> K  defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N  defx#do_action('new_multiple_files')

  " Jump
  nnoremap <silent><buffer>  [g :<C-u>call <SID>jump_dirty(-1)<CR>
  nnoremap <silent><buffer>  ]g :<C-u>call <SID>jump_dirty(1)<CR>

  " Change directory
  nnoremap <silent><buffer><expr><nowait> \  defx#do_action('cd', getcwd())
  nnoremap <silent><buffer><expr><nowait> &  defx#do_action('cd', getcwd())
  nnoremap <silent><buffer><expr> <BS>  defx#async_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~     defx#async_action('cd')
  nnoremap <silent><buffer><expr> u   defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> 2u  defx#do_action('cd', ['../..'])
  nnoremap <silent><buffer><expr> 3u  defx#do_action('cd', ['../../..'])
  nnoremap <silent><buffer><expr> 4u  defx#do_action('cd', ['../../../..'])

  " Selection
  nnoremap <silent><buffer><expr> *  defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr><nowait> <Space>
    \ defx#do_action('toggle_select') . 'j'

  nnoremap <silent><buffer><expr> S  defx#do_action('toggle_sort', 'Time')
  nnoremap <silent><buffer><expr> C
    \ defx#do_action('toggle_columns', 'indent:mark:filename:type:size:time')
endfunction

let g:defx_git#indicators = {
  \ 'Modified'  : '•',
  \ 'Staged'    : '✚',
  \ 'Untracked' : 'ᵁ',
  \ 'Renamed'   : '≫',
  \ 'Unmerged'  : '≠',
  \ 'Ignored'   : 'ⁱ',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '⁇'
  \ }

let g:defx_icons_column_length = 1
let g:defx_icons_mark_icon = ''

nnoremap <silent> <Leader>e
  \ :<C-u>Defx . -resume -toggle -buffer-name=tab`tabpagenr()`<CR>

nnoremap <silent> <Leader>F
  \ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>

nnoremap <silent> <Leader>,
  \ :<C-u>Defx `escape(expand('%:p:h'), ' :')` -search=`expand('%:p')`<CR>


let g:airline_powerline_fonts = 1


"vim-startify
"
let g:startify_bookmarks = [ '~/.profile',
            \ '~/.config/nvim/modules/fuzzyfind/config.vim',
            \ '~/.tmux.conf',
            \ '~/.tmux.conf.local',
            \ '~/.tmux.conf.bak']

nnoremap <silent> <Space>st<Space> :Startify<CR>



"lastbuf
map <Space>b<Space> :LastBuf<CR>
