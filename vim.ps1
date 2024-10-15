$content = @"
" --- Inicio de la configuración de Vim ---

" Habilitar la numeración de líneas
set number

" Establecer el ancho de tabulación y el tipo de tabulación
set tabstop=2
set shiftwidth=2
set expandtab

" Habilitar el resaltado de sintaxis
syntax enable

" Mostrar números de línea relativa
set relativenumber

" Mostrar el número de columna y fila actual en la esquina inferior derecha
set ruler

" Mostrar el estado de encuadre
set showmatch

" Atajos de teclado para abrir/cerrar el explorador de archivos NERDTree
nnoremap <F3> :NERDTreeToggle<CR>
inoremap <F3> <Esc>:NERDTreeToggle<CR>i

" Configuración de complementos con Vim-Plug
call plug#begin('~\vimfiles\plugged')

" Plugins Básicos
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'

" --- Plugins para Desarrollo en Python ---

" Autocompletado y Soporte de Lenguaje
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'davidhalter/jedi-vim'  " Alternativa ligera para autocompletado

" Linting y Formateo
Plug 'dense-analysis/ale'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Navegación y Exploración
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Integración con Git
Plug 'tpope/vim-fugitive'

" Depuración
Plug 'puremourning/vimspector'

" Manejo de Entornos Virtuales
Plug 'jmcantrell/vim-virtualenv'

call plug#end()

" Configurar el tema gruvbox
set background=dark
colorscheme gruvbox

" Remap de navegación para teclado Dvorak
" Quita las comillas
" QWERTY h,j,k,l → Dvorak d,h,t,n
"nnoremap d h
"nnoremap h j
"nnoremap t k
"nnoremap n l

" Opcional: Remap en modo visual para Dvorak
"vnoremap d h
"vnoremap h j
"vnoremap t k
"vnoremap n l

" --- Configuraciones Adicionales de Plugins ---

" Configuración de coc.nvim
" Usa <Tab> y <S-Tab> para navegar por las opciones de completado
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Mapear la tecla Enter para aceptar la selección de completado
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

" Mapeos para comandos de coc.nvim
nnoremap <silent> <leader>rn :CocRename<CR>
nnoremap <silent> <leader>ca :CocCodeAction<CR>

" Configuración de ALE
let g:ale_linters = {
\   'python': ['flake8', 'mypy'],
\}

let g:ale_fixers = {
\   'python': ['black', 'autopep8'],
\}

let g:ale_python_flake8_executable = 'flake8'
let g:ale_python_black_executable = 'black'

" Habilitar la corrección automática al guardar
let g:ale_fix_on_save = 1

" Configuración de UltiSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

" Habilitar el uso de snippets en modo inserción
imap <silent><expr> <Tab> UltiSnips#CanExpandSnippet() ? '<C-R>=UltiSnips#ExpandSnippet()<CR>' : '<Tab>'

" Mapeos rápidos para fzf.vim
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-f> :Rg<CR>

" Configuración básica de Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

" Configuración de vim-virtualenv
nmap <leader>ev :VenvActivate<CR>
nmap <leader>ed :VenvDeactivate<CR>

" --- Fin de la configuración ---
"@
Set-Content -Path $vimrcPath -Value $content -Force
