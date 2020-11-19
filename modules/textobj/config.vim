
let g:sandwich_no_default_key_mappings = 1
let g:operator_sandwich_no_default_key_mappings = 1
let g:textobj_sandwich_no_default_key_mappings = 1

let g:dsf_no_mappings = 1
let g:niceblock_no_default_key_mappings = 0
let g:textobj_multiblock_no_default_key_mappings = 1
let g:textobj_function_no_default_key_mappings = 1

silent! xmap I  <Plug>(niceblock-I)
silent! xmap gI <Plug>(niceblock-gI)
silent! xmap A  <Plug>(niceblock-A)

xmap v <Plug>(expand_region_expand)
xmap V <Plug>(expand_region_shrink)

nmap dsf <Plug>DsfDelete
nmap csf <Plug>DsfChange

let g:splitjoin_join_mapping = ''
let g:splitjoin_split_mapping = ''
nmap sj :SplitjoinJoin<CR>
nmap sk :SplitjoinSplit<CR>

xmap p <Plug>(operator-replace)

omap <silent> ab <Plug>(textobj-multiblock-a)
omap <silent> ib <Plug>(textobj-multiblock-i)
xmap <silent> ab <Plug>(textobj-multiblock-a)
xmap <silent> ib <Plug>(textobj-multiblock-i)

omap <silent> af <Plug>(textobj-function-a)
omap <silent> if <Plug>(textobj-function-i)
xmap <silent> af <Plug>(textobj-function-a)
xmap <silent> if <Plug>(textobj-function-i)
