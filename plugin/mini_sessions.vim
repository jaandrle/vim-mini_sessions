
" #region Guard
if exists('g:load_mini_session')
  finish
endif
let g:load_mini_session = 1

let s:save_cpo = &cpo
set cpo&vim
" #endregion

let g:sessions_dir= $HOME."/.vim/sessions/"
if(filewritable(g:sessions_dir) != 2)
    exe 'silent !mkdir -p ' g:sessions_dir
    redraw!
endif
let s:this_session_saving= 0

function! mini_sessions#save(path_session)
    exe "mksession! ".a:path_session
endfunction
function! mini_sessions#create(name)
    let b:swd= input("Session working directory:\n", execute('pwd'), "file")
    exe "cd ".b:swd
    exe "lcd ".b:swd
    call mini_sessions#save(g:sessions_dir.a:name.".vim")
    echo "\nSession '".a:name."' successfully created."
endfunction
function! mini_sessions#autosave()
    if v:this_session=='' || s:this_session_saving
        return 0
    endif
    let s:this_session_saving=1
    call mini_sessions#save(v:this_session)
    let s:this_session_saving=0
endfunction
function! mini_sessions#open()
    call feedkeys(':so '.g:sessions_dir."	", 'tn')
endfunction

augroup mini_sessions
    autocmd!
    autocmd VimLeave,BufWritePost * :call mini_sessions#autosave()
augroup END

" #region Finish
let &cpo = s:save_cpo
unlet s:save_cpo
" #endregion

" vim: set tabstop=4 shiftwidth=4 textwidth=250 expandtab :
" vim>60: set foldmethod=marker foldmarker=#region,#endregion :
