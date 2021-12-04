
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
    let s:this_session_saving=1
    exe "mksession! ".a:path_session
    let s:this_session_saving=0
endfunction
function! mini_sessions#create(name)
    let b:swd= input("Session working directory:\n", execute('pwd'), "file")
    exe "cd ".b:swd
    exe "lcd ".b:swd
    let b:name= fnameescape(a:name)
    call mini_sessions#save(g:sessions_dir.b:name.".vim")
    echo "\nSession '".b:name."' successfully created."
endfunction
function! mini_sessions#open() abort
    call feedkeys(':so '.g:sessions_dir."	", 'tn')
endfunction
function! mini_sessions#sessionConfig() abort
    if v:this_session==''
        echo 'You must open session first!'
        return 0
    endif
    exe 'e '.join(split(v:this_session, '\.')[0:-2], '.').'x.vim'
endfunction

function! s:Autosave() abort
    if v:this_session=='' || s:this_session_saving
        return 0
    endif
    call mini_sessions#save(v:this_session)
endfunction
augroup mini_sessions
    autocmd!
    autocmd VimLeave,BufWritePost * :call <sid>Autosave()
augroup END

" #region Finish
let &cpo = s:save_cpo
unlet s:save_cpo
" #endregion

" vim: set tabstop=4 shiftwidth=4 textwidth=250 expandtab :
" vim>60: set foldmethod=marker foldmarker=#region,#endregion :
