
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
let g:coc_status_error_sign = '•'
let g:coc_status_warning_sign = '•'


let g:coc_global_extensions =[
	\ 'coc-snippets',
	\ 'coc-pairs',
	\ 'coc-json',
	\ 'coc-highlight',
	\ 'coc-git',
	\ 'coc-emoji',
	\ 'coc-lists',
	\ 'coc-stylelint',
	\ 'coc-yaml',
	\ 'coc-gitignore',
	\ 'coc-yank',
	\ 'coc-actions',
	\ 'coc-db',
	\ 'coc-spell-checker',
	\ 'coc-vimlsp',
    \]



augroup coc_event
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

"Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"--------------------------"
"     Coc Keymap           "
"--------------------------"
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
    execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <Leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <Leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
" Do default action for next item.
nmap <silent> [a  :<C-u>CocNext<CR>
" Do default action for previous item.
nmap <silent> ]a  :<C-u>CocPrev<CR>
" Use [e and ]e for navigate diagnostics
nmap <silent> ]e <Plug>(coc-diagnostic-prev)
nmap <silent> [e <Plug>(coc-diagnostic-next)
" Remap for rename current word
nmap <Leader>cn <Plug>(coc-rename)
" Remap for format selected region
vmap <Leader>cf  <Plug>(coc-format-selected)
nmap <Leader>cf  <Plug>(coc-format-selected)
" Fix autofix problem of current line
nmap <Leader>cF  <Plug>(coc-fix-current)
" Remap keys for gotos
nmap <silent> gd :<C-u>call initself#definition_other_window()<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> <Leader>ci <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K for show documentation in float window
nnoremap <silent> K :call CocActionAsync('doHover')<CR>
" use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
nmap ]g <Plug>(coc-git-prevchunk)
nmap [g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap <Leader>gi <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap <Leader>gm <Plug>(coc-git-commit)
" float window scroll
nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"
" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)
" Add :OR command for organize imports of the current buffer.
command! -nargs=0 OR  :call CocAction('runCommand', 'editor.action.organizeImport')
nnoremap <silent> <Leader>co :<C-u>OR<CR>
" multiple cursors
nmap <silent><M-s> <Plug>(coc-cursors-position)
nmap <expr> <silent><M-d> initself#select_current_word()
xmap <silent><M-d> <Plug>(coc-cursors-range)
nmap <silent><M-c>  <Plug>(coc-cursors-operator)

" Use :Format for format current buffer
command! -nargs=0 Format :call CocAction('format')

nnoremap  <Leader>fz :<C-u>CocSearch -w<Space>
" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
nmap gcj :execute 'CocCommand docthis.documentThis'<CR>
