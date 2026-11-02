" Sourced by copy-mode.sh: q quits, and every yank also goes to the system
" clipboard through the terminal (OSC 52), so it works without a clipboard tool and in remote spaces.
nnoremap <buffer> q :qa!<CR>
autocmd TextYankPost <buffer> call system('base64 | tr -d "\n" | { printf "\033]52;c;"; cat; printf "\a"; } > /dev/tty', join(v:event.regcontents, "\n") . (v:event.regtype ==# 'V' ? "\n" : ''))
normal! G
