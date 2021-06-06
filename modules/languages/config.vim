
" Auto generate the comment for function or method
nnoremap gcg :GoAuToComment<CR>

call coc#config('languageserver', {
\ 'golang': {
	\ "command": "gopls",
	\ "rootPatterns": ["go.mod"],
	\ "disableWorkspaceFolders": "true",
	\ "filetypes": ["go"]
	\ }
	\})

call coc#add_extension('coc-solargraph')

call coc#config('languageserver', {
\ 'bash': {
	\ "command": "bash-language-server",
	\ "args" : ["start"],
	\ "ignoredRootPaths": ["~"],
	\ "filetypes": ["sh"]
	\ }
	\})

let g:python_highlight_all = 1
"call coc#add_extension('coc-python')


" vim-terraform
let g:terraform_fmt_on_save=1
