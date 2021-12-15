" #region Guard
if exists('g:load_mini_session')
  finish
endif
let g:load_mini_session = 1

let s:save_cpo = &cpo
set cpo&vim
" #endregion
let g:mini_session#directory= ( $VIMHOME ? $VIMHOME : $HOME."/.vim" ) . "/sessions/"
if(filewritable(g:mini_session#directory) != 2) | exe 'silent !mkdir -p '.g:mini_session#directory | redraw! |  endif
let s:this_session_saving= 0
let s:this_session_pwd= ''

function! mini_sessions#create(name) abort
    let b:swd= input("Session working directory:\n", execute('pwd'), "file")
    exe 'cd '.b:swd
    let b:name= fnameescape(a:name)
    call <sid>Save(g:mini_session#directory.b:name.".vim")
    echo "\nSession '".b:name."' successfully created."
endfunction

function! mini_sessions#sessionConfig() abort
    if v:this_session=='' | echo 'You must open session first!' | return 0 | endif
    exe 'e '.v:this_session->split('\.')[0:-2]->join('.').'x.vim'
endfunction

function! mini_sessions#open(...) abort " primary backward compatibility
    let prefill= !a:0 ? '' : a:1
    call feedkeys(':so '.g:mini_session#directory.prefill."	", 'tn')
endfunction
function! mini_sessions#load(name) abort
    execute 'so '.g:mini_session#directory.a:name.'.vim'
endfunction
function! mini_sessions#complete(word_start, ...) abort
    let idx= g:mini_session#directory->len()
    let candidates= glob(g:mini_session#directory.'*.vim')->split('\n')
        \ ->map({ _, v -> v[idx:-5] })
    return candidates->filter({ _, v -> v=~a:word_start && ( v[-1:]!='x' || candidates->index(v[:-2])==-1 ) })
endfunction

function! mini_sessions#recoverPwd()
    exe 'cd '.s:this_session_pwd
    pwd
endfunction
" #region Private
function! s:Save(path_session)
    let s:this_session_saving=1
    exe "mksession! ".a:path_session
    let s:this_session_saving=0
endfunction
function! s:Autosave() abort
    if v:this_session=='' || s:this_session_saving
        return 0
    endif
    call <sid>Save(v:this_session)
endfunction
augroup mini_sessions
    autocmd!
    autocmd VimLeave,BufWritePost * :call <sid>Autosave()
    autocmd SessionLoadPost * :let s:this_session_pwd= trim(execute('pwd'))
augroup END
" #endregion Private
" #region Finish
let &cpo = s:save_cpo
unlet s:save_cpo
" #endregion
" vim: set tabstop=4 shiftwidth=4 textwidth=250 expandtab :
" vim>60: set foldmethod=marker foldmarker=#region,#endregion :
