
let g:indentLine_enabled = 1
let g:indentLine_char='┆'
let g:indentLine_fileTypeExclude = ['defx', 'denite','startify','tagbar','vista_kind','vista','coc-explorer','dashboard']
let g:indentLine_concealcursor = 'niv'
let g:indentLine_showFirstIndentLevel =1

let g:vista#renderer#enable_icon = 1
let g:vista_disable_statusline = 1
let g:vista_default_executive = 'ctags'
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_vimwiki_executive = 'markdown'
let g:vista_executive_for = {
  \ 'vimwiki': 'markdown',
  \ 'pandoc': 'markdown',
  \ 'markdown': 'toc',
  \ 'yaml': 'coc',
  \ 'typescript': 'coc',
  \ 'typescriptreact': 'coc',
  \ }

nnoremap <silent> <C-t> :<C-u>Vista!!<CR>

let g:gutentags_cache_dir = $DATA_PATH . '/tags'
let g:gutentags_project_root = ['.root', '.git', '.svn', '.hg', '.project','go.mod','/usr/local']
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_new = 0
let g:gutentags_exclude_filetypes = [ 'defx', 'denite', 'vista', 'magit' ]
let g:gutentags_ctags_extra_args = ['--output-format=e-ctags']
let g:gutentags_ctags_exclude = ['*.json', '*.js', '*.ts', '*.jsx', '*.css', '*.less', '*.sass', '*.go', '*.dart', 'node_modules', 'dist', 'vendor']

let g:quickrun_config = {
  \   "_" : {
    \       "outputter" : "message",
    \   },
    \}
let g:quickrun_no_default_key_mappings = 1

nnoremap <silent> <Leader>cr :QuickRun<CR>
