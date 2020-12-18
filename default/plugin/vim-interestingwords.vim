"=============================================================================
" FILE: vim-easy-align.vim
" AUTHOR:  Alex Layton <omytty.alex@126.com>
" License: MIT license
"
" Word highlighting and navigation throughout out the buffer.
" https://github.com/lfv89/vim-interestingwords
"=============================================================================

let g:interestingWordsDefaultMappings = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => listener
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function ListenerPlugLoadedInterestingwords()
  if HasPlug('vim-interestingwords')
    nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
    vnoremap <silent> <leader>k :call InterestingWords('v')<cr>
    nnoremap <silent> <leader>K :call UncolorAllWords()<cr>

    nnoremap <silent> n :call WordNavigation(1)<cr>
    nnoremap <silent> N :call WordNavigation(0)<cr>
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => trigger
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PlugOptionDoInterestingwords(...)
  call ListenerPlugLoadedInterestingwords()
endfunction

Plug 'lfv89/vim-interestingwords', { 'do': function('PlugOptionDoInterestingwords') }

call AutocmdAmPlugLoaded('ListenerPlugLoadedInterestingwords')
