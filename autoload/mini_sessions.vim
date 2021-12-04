function! mini_sessions#name(default)
    if v:this_session=='' | return a:default | endif
    let filename= split(v:this_session, '/')[-1]
    return join(split(filename, '\.')[0:-2], '.')
endfunction
" vim: set tabstop=4 shiftwidth=4 textwidth=250 expandtab :
" vim>60: set foldmethod=marker foldmarker=#region,#endregion :
