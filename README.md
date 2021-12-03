# mini_sessions.vim

Minimalistics sessions for Vim using build-in behaviour (see `:help mksession`).
There are only three changes:

1) project/sessions root directory is also saved as `(l)cd`
1) sessions files are stored only in `~/.vim/sessions`, opening function
just prefill `:so ~/.vim/sessions/` and triggers completion (`:help wildmenu`)
1) plugin manages saving when you saving buffer and or leaving Vim.

## Installation

Install using your favorite package manager, or use Vim's built-in package
support:

    mkdir -p ~/.vim/bundle/vim-mini_sessions
    cd ~/.vim/bundle/vim-mini_sessions
    git clone https://github.com/jaandrle/vim-mini_sessions.git

## `.vimrc` examples
```
set runtimepath^=~/.vim/bundle/*
set statusline+=:%{mini_sessions#name()}\ 
command! -nargs=1 SessionCreate :call mini_sessions#create(<f-args>)
nnoremap <leader>S :call mini_sessions#open()
```

## Build-in sessions tips
- see `:help sessionoptions` (I use `set sessionoptions-=options`)
- you can define session specific stuffs inside file endings with __x__,
  so your `~/.vim/sessions` can looks:
```
    session.vim
    sessionx.vim
```
