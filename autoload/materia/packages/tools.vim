"=============================================================================
" FILE: tools.vim
" AUTHOR:  Alex Layton <omytty.alex@126.com>
" License: MIT license
"=============================================================================

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nerdtree
" The NERDTree is a file system explorer for the Vim editor.
" https://github.com/preservim/nerdtree
" https://github.com/PhilRunninger/nerdtree-visual-selection
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:nerdtree = {}
function! s:nerdtree.config()
  let g:NERDTreeShowBookmarks = materia#conf('packages.nerdtree.bookmarks')
  " let g:NERDTreeWinPos="dark"
  let g:NERDTreeShowLineNumbers = materia#conf('packages.nerdtree.show_line_numbers')
  let g:NERDTreeAutoCenter=0
  let g:NERDTreeHighlightCursorline = 1
  let g:NERDTreeShowFiles = 1
  " avoid crashes when calling vim-plug functions while the cursor is on the NERDTree window
  let g:plug_window = 'noautocmd vertical topleft new'
  " hide the boring brackets([ ])
  let g:NERDTreeGitStatusConcealBrackets = 1

  let g:NERDTreeDirArrowExpandable = '▷'
  let g:NERDTreeDirArrowCollapsible = '▽'
endfunction
function! s:nerdtree.listener()
  let key_prefix = GetConfigMapPrefix(materia#conf('packages.nerdtree.basekey'))
  let key_toggle = materia#conf('packages.nerdtree.key_toggle')
  let key_focus = materia#conf('packages.nerdtree.key_focus')
  execute 'nnoremap <silent> '. key_prefix.edge .'o :<C-u>NERDTreeToggle<CR>'
  execute 'nnoremap <silent> '. key_prefix.edge .'f :<C-u>NERDTreeFocus<CR>'
endfunction
function! s:nerdtree.install(install)
  call a:install('preservim/nerdtree')
  if materia#conf('packages.nerdtree.visual_selection')
    call a:install('PhilRunninger/nerdtree-visual-selection')
  endif
  if materia#conf('packages.nerdtree.buffer_ops')
    call a:install('PhilRunninger/nerdtree-buffer-ops')
  endif
  \| call a:install('Xuyuanp/nerdtree-git-plugin')
endfunction
call materia#packages#add_package('nerdtree', s:nerdtree)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => undotree
" The plug-in visualizes undo history and makes it easier to browse and switch between different undo branches
" https://github.com/mbbill/undotree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:undotree = {}
function! s:undotree.listener()
  let key_prefix = GetConfigMapPrefix(materia#conf('packages.nerdtree.basekey'))
  execute 'nnoremap <silent> '. key_prefix.edge .'u :<C-u>UndotreeToggle<CR>'
endfunction
function! s:undotree.install(install)
  call a:install('mbbill/undotree')
endfunction
call materia#packages#add_package('undotree', s:undotree)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim_tmux_navigator
" Seamless navigation between tmux panes and vim splits
" https://github.com/christoomey/vim-tmux-navigator
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_tmux_navigator = {}
function! s:vim_tmux_navigator.install(install)
  call a:install('christoomey/vim-tmux-navigator')
endfunction
call materia#packages#add_package('vim_tmux_navigator', s:vim_tmux_navigator)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vista_vim
" View and search LSP symbols, tags in Vim/NeoVim.
" https://github.com/liuchengxu/vista.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vista_vim = {}
function! s:vista_vim.config()
  let g:vista_sidebar_width = 35
  let g:vista#renderer#enable_icon = 1
  let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
  let g:vista#executives = ['coc']
  let g:vista_executive_for = {
  \ 'php': 'coc', 'html': 'coc', 'css': 'coc'
  \ }
endfunction
function! s:vista_vim.listener()
  nnoremap <silent> <leader>vv :Vista!!<CR>
  nnoremap <silent> <leader>vf :Vista finder<CR>
endfunction
function! s:vista_vim.install(install)
  call a:install('liuchengxu/vista.vim')
endfunction
call materia#packages#add_package('vista_vim', s:vista_vim)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim_fugitive
" Fugitive is the premier Vim plugin for Git. Or maybe it's the premier Git plugin for Vim?
" https://github.com/tpope/vim-fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_fugitive = {}
function! s:undotree.option()
  if HasPlug('vim-fugitive')
    set statusline+=%{FugitiveStatusline()}
  endif
endfunction
function! s:vim_fugitive.listener()
  let key_prefix = GetConfigMapPrefix(materia#conf('packages.vim_fugitive.basekey'))
  execute 'nnoremap <silent> '. key_prefix.view .'g :<C-u>Git --paginate<CR>'
  execute 'nnoremap <silent> '. key_prefix.view .'d :<C-u>Git diff<CR>'
  execute 'nnoremap <silent> '. key_prefix.view .'l :<C-u>Git log<CR>'
  execute 'nnoremap <silent> '. key_prefix.view .'r :<C-u>Git reflog<CR>'
  execute 'nnoremap <silent> '. key_prefix.view .'b :<C-u>Git blame<CR>'
  execute 'nnoremap <silent> '. key_prefix.win .'m :<C-u>Git mergetool<CR>'
  execute 'nnoremap <silent> '. key_prefix.win .'d :<C-u>Git difftool<CR>'
  execute 'nnoremap <silent> '. key_prefix.win .'s :<C-u>Gdiffsplit<CR>'
  execute 'nnoremap <silent> '. key_prefix.win .'o :<C-u>GBrowse<CR>'
  execute 'nnoremap <silent> '. key_prefix.action .'r :<C-u>Gread<CR>'
  execute 'nnoremap <silent> '. key_prefix.action .'w :<C-u>Gwrite<CR>'
endfunction
function! s:vim_fugitive.install(install)
  call a:install('tpope/vim-fugitive')
endfunction
call materia#packages#add_package('vim_fugitive', s:vim_fugitive)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim_gitgutter
" A Vim plugin which shows a git diff in the sign column.
" https://github.com/airblade/vim-gitgutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_gitgutter = {}
function! s:vim_gitgutter.option()
  set foldtext=gitgutter#fold#foldtext()
endfunction
function! s:vim_gitgutter.config()
  let g:gitgutter_max_signs = -1
  let g:gitgutter_map_keys = 0
  let g:gitgutter_preview_win_floating = 1
endfunction
function! s:vim_gitgutter.listener()
  let okey = materia#conf('packages.vim_gitgutter.basekey')
  let nkey = materia#conf('options.maps.next')
  let pkey = materia#conf('options.maps.prev')
  let key_prefix = GetConfigMapPrefix(materia#conf('packages.vim_gitgutter.basekey'))
  highlight! link SignColumn LineNr 
  " Jump to hunks
  execute 'nmap '. key_prefix.next .' <Plug>(GitGutterNextHunk)'
  execute 'nmap '. key_prefix.prev .' <Plug>(GitGutterPrevHunk)'

  execute 'nmap '. key_prefix.view .'h :<C-u>GitGutterToggle<CR>'
  execute 'nmap '. key_prefix.view .'b :<C-u>GitGutterBufferToggle<CR>'
  execute 'nmap '. key_prefix.view .'i :<C-u>GitGutterSignsToggle<CR>'
  execute 'nmap '. key_prefix.view .'l :<C-u>GitGutterLineHighlightsToggle<CR>'
  execute 'nmap '. key_prefix.view .'n :<C-u>GitGutterLineNrHighlightsToggle<CR>'
  execute 'nmap '. key_prefix.view .'f :<C-u>GitGutterFold<CR>'
  execute 'nmap '. key_prefix.view .'p :<C-u>GitGutterPreviewHunk<CR>'
  execute 'nmap '. key_prefix.action .'s <Plug>(GitGutterStageHunk)'
  execute 'nmap '. key_prefix.action .'u <Plug>(GitGutterUndoHunk)'

  function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
  endfunction
  set statusline+=%{GitStatus()}
endfunction
function! s:vim_gitgutter.install(install)
  call a:install('airblade/vim-gitgutter')
endfunction
call materia#packages#add_package('vim_gitgutter', s:vim_gitgutter)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim_gitgutter
" A Vim plugin which shows a git diff in the sign column.
" https://github.com/airblade/vim-gitgutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:materia_session = {}
function! s:materia_session.config()
  let g:materia_session_mode = materia#conf('packages.materia_session.mode')
  let g:materia_session_directory = materia#homepath('/temp/sessions')
  let g:session_autosave_on_actions = materia#conf('packages.materia_session.autosave_on_actions')
endfunction

function! s:materia_session.listener()
  if g:loaded_materia_session
    if materia#conf('packages.materia_session.autoload')
      call MateriaSessionLoad()
    endif
    if materia#conf('packages.materia_session.autosave')
      autocmd VimLeavePre * :<C-u>MateriaSessionSave<CR>
    endif
  endif
endfunction

function! s:materia_session.install(install)
  call a:install('speed-sonic/vim-materia-session')
endfunction

call materia#packages#add_package('materia_session', s:materia_session)
