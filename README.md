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
- see `:help wildmode` (I use `set wildmode=list:longest,list:full`)
- use nicknames as sessions names, also you can group your sessions
in form of (better for autocompetition): `group_session_app.vim`, `group_session_web.vim`, …
- you can define session specific stuffs inside file endings with __x__,
  so your `~/.vim/sessions` can looks:
```
    your_session_name.vim (*)
    your_session_namex.vim
```
…do nothing with (\*) file (unless you know what are you dooing), this file is
natievly generated by Vim – you can only specify name (using `mini_sessions#create(__name__)`).

## Do I need to convert directory specific `Session.vim`

No. Everythig should works as usual without this plugin. The plugin gives you
only one benefit that is _autosaving_.

For ability to open session for example from yout Intro page (via `mini_sessions#open`),
you need to move `Session.vim` into `~/.vim/sessions` and rename it. The file name is
in fact project/session name.
