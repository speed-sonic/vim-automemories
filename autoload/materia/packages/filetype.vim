"=============================================================================
" FILE: filetype.vim
" AUTHOR:  Alex Layton <omytty.alex@126.com>
" License: MIT license
"=============================================================================

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => html5_vim
" HTML5 + inline SVG omnicomplete function, indent and syntax for Vim. Based on the default htmlcomplete.vim.
" https://github.com/othree/html5.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:html5_vim = {}
function! s:html5_vim.config()
  let g:html5_event_handler_attributes_complete = materia#conf('packages.html5_vim.attr_event_handler')
  let g:html5_rdfa_attributes_complete = materia#conf('packages.html5_vim.attr_rdfa')
  let g:html5_microdata_attributes_complete = materia#conf('packages.html5_vim.attr_microdata')
  let g:html5_aria_attributes_complete = materia#conf('packages.html5_vim.attr_aria')
endfunction
function! s:html5_vim.listener()
  let filetypes = materia#conf('packages.html5_vim.filetypes')
  execute 'autocmd FileType '. join(filetypes, ',') .' EmmetInstall'
endfunction
function! s:html5_vim.install(install)
  call a:install('othree/html5.vim')
endfunction
call materia#packages#add_package('html5_vim', s:html5_vim)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => emmet_vim
" emmet-vim is a vim plug-in which provides support for expanding abbreviations similar to emmet.
" https://github.com/mattn/emmet-vim
" snippets.json Doc:
" https://docs.emmet.io/customization/snippets/
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:emmet_vim = {}
function! s:emmet_vim.config()
  if materia#conf('html.snippet_path')
    let g:user_emmet_install_global = 0
    let g:user_emmet_leader_key = materia#conf('packages.emmet_vim.leader_key')
    let snippet_path = materia#conf('packages.emmet_vim.snippet_path')
    if snippet_path
      let g:user_emmet_settings = webapi#json#decode(join(readfile(expand(s:snippet_path)), "\n"))
    endif
  endif
endfunction
function! s:emmet_vim.listener()
  if (exists('g:loaded_emmet_vim') && g:loaded_emmet_vim)
    let filetypes = materia#conf('packages.emmet_vim.filetypes')
    execute 'autocmd FileType '. join(filetypes, ',') .' EmmetInstall'
  endif
endfunction
function! s:emmet_vim.install(install)
  call a:install('mattn/emmet-vim')
endfunction
call materia#packages#add_package('emmet_vim', s:emmet_vim)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => syntastic
" Syntastic is a syntax checking plugin for Vim created by Martin Grenfell.
" It runs files through external syntax checkers and displays any resulting errors to the user.
" https://github.com/vim-syntastic/syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:syntastic = {}
function! s:syntastic.options()
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
endfunction
function! s:syntastic.config()
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
endfunction
function! s:syntastic.install(install)
  call a:install('vim-syntastic/syntastic')
endfunction
call materia#packages#add_package('syntastic', s:syntastic)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nginx
" Improved nginx vim plugin (incl. syntax highlighting)
" https://github.com/chr4/nginx.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:nginx = {}
function! s:nginx.install(install)
  call a:install('chr4/nginx.vim')
endfunction
call materia#packages#add_package('nginx', s:nginx)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim_go
" Go development plugin for Vim
" https://github.com/fatih/vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_go = {}
function! s:vim_go.config()
  let g:go_def_mode='gopls'
  let g:go_info_mode='gopls'
  let g:go_fmt_autosave = 0
  let g:go_fmt_command = 'goimports'
  let g:go_fmt_fail_silently = 1
  " this breaks folding on vim < 8.0 or neovim
  if v:version >= 800 || has('nvim')
    let g:go_fmt_experimental = 1
  endif
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_generate_tags = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_types = 1
  " let g:go_highlight_function_calls = 1

  autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
  autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
  autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
  autocmd FileType go nmap gtx :CocCommand go.tags.clear<cr>
  " Quickly execute your current file(s)
  autocmd FileType go nmap gr :<C-u>GoRun<cr>
  autocmd FileType go nmap gb :<C-u>GoBuild<cr>
  autocmd FileType go nmap gi :<C-u>GoInstall<cr>
  autocmd FileType go nmap gd :<C-u>GoDebugStart<cr>
  autocmd FileType go nmap gte :<C-u>GoInstall<cr>
endfunction
function! s:vim_go.listener()
endfunction
function! s:vim_go.install(install)
  call a:install('fatih/vim-go', { 'do': ':GoUpdateBinaries' })
endfunction
call materia#packages#add_package('vim_go', s:vim_go)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim_javascript
" JavaScript bundle for vim, this bundle provides syntax highlighting and improved indentation.
" https://github.com/pangloss/vim-javascript
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_javascript = {}
function! s:vim_javascript.config()
  let g:javascript_plugin_jsdoc = materia#conf('packages.vim_javascript.attr_plugin_jsdoc')
  let g:javascript_plugin_ngdoc = materia#conf('packages.vim_javascript.attr_plugin_ngdoc')
  let g:javascript_plugin_flow = materia#conf('packages.vim_javascript.attr_plugin_flow')

  augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
  augroup END
endfunction
function! s:vim_javascript.install(install)
  call a:install('pangloss/vim-javascript')
endfunction
call materia#packages#add_package('vim_javascript', s:vim_javascript)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim_json
" A better JSON for Vim: distinct highlighting of keywords vs values, JSON-specific (non-JS) warnings, quote concealing. Pathogen-friendly.
" https://github.com/elzr/vim-json
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_json = {}
function! s:vim_json.options()
  set conceallevel=0
endfunction
function! s:vim_json.config()
  let g:vim_json_syntax_conceal = materia#conf('packages.vim_json.syntax_conceal')
endfunction
function! s:vim_json.install(install)
  call a:install('elzr/vim-json')
endfunction
call materia#packages#add_package('vim_json', s:vim_json)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim_jsx
" React JSX syntax highlighting and indenting for vim.
" https://github.com/mxw/vim-jsx
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_jsx = {}
function! s:vim_jsx.install(install)
  call a:install('mxw/vim-jsx')
endfunction
call materia#packages#add_package('vim_jsx', s:vim_jsx)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim_markdown
" This is the development version of Vim's included syntax highlighting and filetype plugins for Markdown.
" https://github.com/tpope/vim-markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_markdown = {}
function! s:vim_markdown.config()
  let g:markdown_fenced_languages = materia#conf('packages.vim_markdown.attr_fenced_languages')
  let g:markdown_minlines = materia#conf('packages.vim_markdown.attr_minlines')
endfunction
function! s:vim_markdown.install(install)
  call a:install('tpope/vim-markdown')
endfunction
call materia#packages#add_package('vim_markdown', s:vim_markdown)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim_livedown
" https://github.com/shime/vim-livedown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_livedown = {}
function! s:vim_livedown.config()
endfunction
function! s:vim_livedown.listener()
  let okey = materia#conf('packages.vim_livedown.basekey')
  execute 'nnoremap <silent> <C-'. okey .'> :<C-u>LivedownToggle<CR>'
endfunction
function! s:vim_livedown.install(install)
  call a:install('shime/vim-livedown', { 'do': 'yarn global add livedown' })
endfunction
call materia#packages#add_package('vim_livedown', s:vim_livedown)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim_peekaboo
" Peekaboo will show you the contents of the registers on the sidebar when you hit " or @ in normal mode or <CTRL-R> in insert mode.
" The sidebar is automatically closed on subsequent key strokes.
" You can toggle fullscreen mode by pressing spacebar.
" https://github.com/junegunn/vim-peekaboo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_peekaboo = {}
function! s:vim_peekaboo.config()
  let g:peekaboo_delay = materia#conf('packages.vim_peekaboo.attr_delay')
  let g:peekaboo_compact = materia#conf('packages.vim_peekaboo.attr_compact')
  let g:peekaboo_prefix = materia#conf('packages.vim_peekaboo.attr_prefix')
  let g:peekaboo_ins_prefix = materia#conf('packages.vim_peekaboo.attr_ins_prefix')
endfunction
function! s:vim_peekaboo.install(install)
  call a:install('junegunn/vim-peekaboo')
endfunction
call materia#packages#add_package('vim_peekaboo', s:vim_peekaboo)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim_floaterm
" Use (neo)vim terminal in the floating/popup window.
" https://github.com/voldikss/vim-floaterm
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_floaterm = {}
function! s:vim_floaterm.options()
  " Set floaterm window's background to black
  hi Floaterm guibg=black
  " Set floating window border line color to cyan, and background to orange
  hi FloatermBorder guibg=orange guifg=cyan
  " Set floaterm window background to gray once the cursor moves out from it
  hi FloatermNC guibg=gray
endfunction
function! s:vim_floaterm.config()
  let okey = materia#conf('packages.vim_floaterm.basekey')
  let nkey = materia#conf('options.maps.next')
  let pkey = materia#conf('options.maps.prev')
  let key_prefix = GetConfigMapPrefix(okey)
  let g:floaterm_keymap_new = key_prefix.edge . 'n'
  let g:floaterm_keymap_prev = pkey . okey
  let g:floaterm_keymap_next = nkey . okey
  let g:floaterm_keymap_toggle = key_prefix.edge . okey
  let g:floaterm_keymap_kill = '<C-d>'
  let g:floaterm_title = materia#conf('packages.vim_floaterm.title')
  let g:floaterm_width = materia#conf('packages.vim_floaterm.width')
  let g:floaterm_height = materia#conf('packages.vim_floaterm.height')
  let g:floaterm_rootmarkers = materia#conf('packages.vim_floaterm.rootmarkers')
  " Close window if the job exits normally, otherwise stay it with messages like [Process exited 101]
  let g:floaterm_autoclose = 0
endfunction
function! s:vim_floaterm.listener()
endfunction
function! s:vim_floaterm.install(install)
  call a:install('voldikss/vim-floaterm')
endfunction
call materia#packages#add_package('vim_floaterm', s:vim_floaterm)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim_smooth_scroll
" Use (neo)vim terminal in the floating/popup window.
" https://github.com/voldikss/vim-floaterm
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_smooth_scroll = {}
function! s:vim_smooth_scroll.listener()
  let speed = materia#conf('packages.vim_smooth_scroll.speed')
  execute 'noremap <silent> <c-u> :call smooth_scroll#up(&scroll, '. speed .', 1)<CR>'
  execute 'noremap <silent> <c-d> :call smooth_scroll#down(&scroll, '. speed .', 1)<CR>'
  execute 'noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, '. speed .', 1)<CR>'
  execute 'noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, '. speed .', 1)<CR>'
endfunction
function! s:vim_smooth_scroll.install(install)
  call a:install('terryma/vim-smooth-scroll')
endfunction
call materia#packages#add_package('vim_smooth_scroll', s:vim_smooth_scroll)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => editorconfig_vim
" This is an EditorConfig plugin for Vim. This plugin can be found on both GitHub and Vim online.
" https://github.com/editorconfig/editorconfig-vim
" https://editorconfig.org/
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:editorconfig_vim = {}
function! s:editorconfig_vim.config()
  let g:EditorConfig_exclude_patterns = materia#conf('packages.editorconfig_vim.exclude_patterns')
endfunction
function! s:editorconfig_vim.listener()
  " disable this plugin for a specific buffer
  let types = materia#conf('packages.editorconfig_vim.disable_types')
  execute 'autocmd FileType '. join(types, ',') .' let b:EditorConfig_disable = 1'
endfunction
function! s:editorconfig_vim.install(install)
  call a:install('editorconfig/editorconfig-vim')
endfunction
call materia#packages#add_package('editorconfig_vim', s:editorconfig_vim)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => webapi_vim
" An Interface to WEB APIs.
" https://github.com/mattn/webapi-vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:webapi_vim = {}
function! s:webapi_vim.install(install)
  call a:install('mattn/webapi-vim')
endfunction
call materia#packages#add_package('webapi_vim', s:webapi_vim)
