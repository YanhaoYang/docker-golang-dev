if has('statusline')
  set laststatus=2

  " Broken down into easily includeable segments
  set statusline=%<%f\    " Filename
  set statusline+=%w%h%m%r " Options
  set statusline+=\ [%{&ff}/%Y]            " filetype
  set statusline+=%{fugitive#statusline()} "  Git Hotness
  "set statusline+=\ [%{getcwd()}]          " current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

nmap <leader>bu :Buffers<CR>
nmap <leader>f :Files<CR>
nmap <leader>m :Marks<CR>
nmap <leader>q :q<CR>
nmap <leader>v :set invpaste paste?<CR>

nnoremap <silent> <C-f> :NERDTreeFind<CR>
map <C-q> :q<CR>
map <C-x> :qa<CR>

nnoremap gc :GoDoc<CR>
nnoremap gp :PreviewMarkdown<CR>

nnoremap gs :%s/\<<C-r><C-w>\>/
nnoremap gw :Ag <C-R><C-W><CR>
nnoremap gr :gr <cword><CR>
nnoremap Gr :grep <cword> %:p:h/*<CR>
nnoremap gR :grep '\b<cword>\b'<CR>
nnoremap GR :grep '\b<cword>\b' %:p:h/*<CR>

nnoremap gb :Gblame<CR>
nnoremap ga :GoAlternate<CR>

" Open all Go source files excluding files in ./vendor
nnoremap fs :args `find . -path ./vendor -prune -o -name '*.go'`<CR>

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

set foldenable                  " auto fold code
set foldmethod=indent
set foldcolumn=2
set foldlevel=1

unmap <space>

set mouse=

set autowrite
augroup AutoWrite
  autocmd! BufLeave * :update
augroup END

let g:syntastic_go_checkers = ['golint', 'govet']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "30s"

autocmd FileType go nmap <leader>i  <Plug>(go-install)
let g:go_fmt_command = "goimports"

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.DS_Store']
let NERDTreeShowHidden=1
