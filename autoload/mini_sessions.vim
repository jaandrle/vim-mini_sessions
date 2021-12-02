
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
set sessionoptions-=options
let g:this_session_name= "—"
let s:this_session_saving= 0

function! mini_sessions#save(name)
    let b:path= g:sessions_dir.a:name.".vim"
    exe "mksession! ".b:path
    let lines= readfile(b:path)
    let session_line= len(lines)-4
    call writefile(lines[0:session_line]+[ "let g:this_session_name='".a:name."'" ]+lines[session_line+1:], b:path)
endfunction
function! mini_sessions#create(name)
    let b:swd= input("Session working directory:\n", system('echo $(pwd)'), "file")
    exe "cd ".b:swd
    exe "lcd ".b:swd
    call mini_sessions#save(a:name)
    echo "\nSession '".a:name."' successfully created."
endfunction
function! mini_sessions#autosave()
    if g:this_session_name == "—" || s:this_session_saving
        return 0
    endif
    let s:this_session_saving=1
    call mini_sessions#save(g:this_session_name)
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
