
function! ctrlg#ctrlg(count)
    if a:count > 1
        unsilent echon 'buf '
        echohl Number
        unsilent echon bufnr()
        echohl Comment
        unsilent echon ': '
    endif
    echohl Comment
    unsilent echon '"'
    echohl String
    let name = expand('%:~:.')
    unsilent echon empty(name) ? '[No Name]' : name
    echohl Comment
    unsilent echon '"'
    echohl NONE
    let extra = ' '
    if &modified
        unsilent echon extra
        let extra = ''
        echohl Error
        unsilent echon (&shm =~# '[am]' ? '[+]' : '[Modified]')
        echohl NONE
    endif
    if &readonly
    endif
    if !empty(name) && !filereadable(expand('%:p'))
        unsilent echon extra
        echohl Type  
        unsilent echon (&shm =~# '[an]' ? '[New]' : '[New File]')
        echohl NONE
    endif
    unsilent echon ' '
    if wordcount().bytes is 0
        echohl Comment
        unsilent echon '--'
        echohl NONE
        unsilent echon 'No lines in buffer'
        echohl Comment
        unsilent echon '--'
    else
        unsilent echon 'line '
        echohl Number
        unsilent echon line('.')
        echohl NONE
        unsilent echon ' of '
        echohl Number
        unsilent echon line('$')
        echohl Comment
        unsilent echon ' --'
        echohl Identifier
        unsilent echon (line('.')*100/line('$')).'%'
        echohl Comment
        unsilent echon '--'
        echohl NONE
        unsilent echon ' col '
        echohl Number
        unsilent echon col('.')
        if (col('.') !=# 1 || !&list) && virtcol('.') !=# col('.')
            unsilent echon '-'.virtcol('.')
        endif
        echohl NONE
    endif
endfunction

function! ctrlg#g_ctrlg()
    let wc = wordcount()
    if wc.bytes is 0
        echohl Comment
        unsilent echon '--'
        echohl None
        unsilent echon 'No lines in buffer'
        echohl Comment
        unsilent echon '--'
        echohl NONE
        return
    endif
    unsilent echon 'Col '
    echohl Number
    unsilent echon col('.')
    if (col('.') !=# 1 || !&list) && virtcol('.') !=# col('.')
        unsilent echon '-'.virtcol('.')
    endif
    echohl NONE
    unsilent echon ' of '
    echohl Number
    unsilent echon col('$')-1
    if (col('$') !=# 1 || !&list) && virtcol('$') !=# col('$')
        unsilent echon '-'.(virtcol('$')-1)
    endif
    echohl Comment
    unsilent echon '; '
    echohl NONE
    unsilent echon 'Line '
    echohl Number
    unsilent echon line('.')
    echohl NONE
    unsilent echon ' of '
    echohl Number
    unsilent echon line('$')
    echohl NONE
    echohl Comment
    unsilent echon '; '
    echohl NONE
    unsilent echon 'Word '
    echohl Number
    unsilent echon wc.cursor_words
    echohl NONE
    unsilent echon ' of '
    echohl Number
    unsilent echon wc.words
    echohl Comment
    unsilent echon '; '
    echohl NONE
    if wc.chars != wc.bytes
        unsilent echon 'Char '
        echohl Number
        unsilent echon wc.cursor_chars
        echohl NONE
        unsilent echon ' of '
        echohl Number
        unsilent echon wc.chars
        echohl Comment
        unsilent echon '; '
        echohl NONE
    endif
    unsilent echon 'Byte '
    echohl Number
    unsilent echon wc.cursor_bytes
    echohl NONE
    unsilent echon ' of '
    echohl Number
    unsilent echon wc.bytes
    echohl NONE
endfunction

function! ctrlg#v_g_ctrlG()
    let [cline, ccol, vline, vcol] = getcurpos()[1:2] + getpos('v')[1:2]
    if cline > vline || cline == vline && ccol >= vcol
        let [start, end] = [vline, cline]
    else
        let [start, end] = [cline, vline]
    endif
    let wc = wordcount()
    unsilent echon "\rSelected "
    echohl Number
    unsilent echon end - start + 1
    echohl NONE
    unsilent echon ' of '
    echohl Number
    unsilent echon line('$')
    echohl NONE
    unsilent echon ' Lines'
    echohl Comment
    unsilent echon '; '
    echohl Number
    unsilent echon wc.visual_words
    echohl NONE
    unsilent echon ' of '
    echohl Number
    unsilent echon wc.words
    echohl NONE
    unsilent echon ' Words'
    echohl Comment
    unsilent echon '; '
    echohl Number
    unsilent echon wc.visual_bytes
    echohl NONE
    unsilent echon ' of '
    echohl Number
    unsilent echon wc.bytes
    echohl NONE
    unsilent echon ' Bytes'
    return ''
endfunction

