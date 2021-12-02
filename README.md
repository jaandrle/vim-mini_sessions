# mini_sessions.vim

Minimalistics sessions for Vim. Just use Vim’s tabs competitions.
Sessions are stored in `~/.vim/sessions`, this script uses native
behaviour (`:help mksession`) with only one modification (adding line
with session name).

## Installation

Install using your favorite package manager, or use Vim's built-in package
support:

    mkdir -p ~/.vim/bundle/vim-mini_sessions
    cd ~/.vim/bundle/vim-mini_sessions
    git clone https://github.com/jaandrle/vim-mini_sessions.git

## `.vimrc` examples
```
set runtimepath^=~/.vim/bundle/*
set statusline+=:%{get(g:,'this_session_name','')}\ 
command! -nargs=1 SessionCreate :call mini_sessions#create(<f-args>)
nnoremap <leader>S :call mini_sessions#open()
```

## TODO
- [ ] better README
- [ ] tbd
