
if get(g:, 'no_plugin_maps') || get(g:, 'no_ctrlg_maps')
    " respect g:no_plugin_maps and g:no_ctrlg_maps
    finish
endif

" ^g with color!
nnoremap <silent> <c-g> :<c-u>call ctrlg#ctrlg(v:count)<cr>
" g_^g with color!
nnoremap <silent> g<c-g> :<c-u>call ctrlg#g_ctrlg()<cr>
" v_g_^g with color!
xnoremap <silent> <expr> g<c-g> ctrlg#v_g_ctrlG()

if get(g:, 'ctrlg_preserve_originals')
    nnoremap <localleader><c-g> <c-g>
    nnoremap <localleader>g<c-g> g<c-g>
    xnoremap <localleader>g<c-g> g<c-g>
endif

if !exists(':tnoremap')
    finish
endif

augroup ctrlg_vim
    autocmd!
    tnoremap <c-w><c-g> <c-w>:<c-u>call ctrlg#ctrlg(v:count)<cr>
    tnoremap <c-w>g<c-g> <c-w>:<c-u>call ctrlg#g_ctrlg()<cr>
augroup end

