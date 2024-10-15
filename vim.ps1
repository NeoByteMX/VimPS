# setup_vim_python_windows.ps1

# Salir inmediatamente si un comando falla
$ErrorActionPreference = "Stop"

# Función para mostrar mensajes informativos
function Write-Info {
    param (
        [string]$Message
    )
    Write-Host "[INFO] $Message" -ForegroundColor Green
}

# Verificar si el script se está ejecutando con permisos de administrador
$currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Este script requiere permisos de administrador. Por favor, ejecútalo como administrador." -ForegroundColor Red
    exit 1
}

# Instalar Chocolatey si no está instalado
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Info "Instalando Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} else {
    Write-Info "Chocolatey ya está instalado."
}

# Actualizar la lista de paquetes
Write-Info "Actualizando la lista de paquetes de Chocolatey..."
choco upgrade chocolatey -y

# Instalar Vim si no está instalado
if (-not (Get-Command vim -ErrorAction SilentlyContinue)) {
    Write-Info "Instalando Vim..."
    choco install vim -y
} else {
    Write-Info "Vim ya está instalado."
}

# Instalar Curl si no está instalado
if (-not (Get-Command curl -ErrorAction SilentlyContinue)) {
    Write-Info "Instalando Curl..."
    choco install curl -y
} else {
    Write-Info "Curl ya está instalado."
}

# Instalar fzf si no está instalado
if (-not (Get-Command fzf -ErrorAction SilentlyContinue)) {
    Write-Info "Instalando fzf..."
    choco install fzf -y
    & "$env:ProgramFiles\fzf\install.ps1" --all
} else {
    Write-Info "fzf ya está instalado."
}

# Instalar Node.js si no está instalado
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Info "Instalando Node.js..."
    choco install nodejs-lts -y
} else {
    Write-Info "Node.js ya está instalado."
}

# Instalar Git si no está instalado
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Info "Instalando Git..."
    choco install git -y
} else {
    Write-Info "Git ya está instalado."
}

# Instalar Python3 si no está instalado
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Info "Instalando Python3..."
    choco install python -y
} else {
    Write-Info "Python3 ya está instalado."
}

# Actualizar pip a la última versión
Write-Info "Actualizando pip..."
python -m pip install --upgrade pip --user

# Descargar Vim-Plug
Write-Info "Descargando Vim-Plug..."
$vimFiles = "$env:USERPROFILE\vimfiles\autoload"
New-Item -Path $vimFiles -ItemType Directory -Force | Out-Null
Invoke-WebRequest -Uri https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -OutFile "$vimFiles\plug.vim"

# Hacer una copia de seguridad del _vimrc existente si existe
$vimrcPath = "$env:USERPROFILE\_vimrc"
if (Test-Path $vimrcPath) {
    Write-Info "Creando copia de seguridad de _vimrc existente..."
    Copy-Item $vimrcPath "$env:USERPROFILE\_vimrc.backup_$(Get-Date -Format 'yyyyMMddHHmmss')"
}

# Crear el archivo _vimrc
Write-Info "Creando archivo _vimrc..."
@"
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
" QWERTY h,j,k,l → Dvorak d,h,t,n
nnoremap d h
nnoremap h j
nnoremap t k
nnoremap n l

" Opcional: Remap en modo visual para Dvorak
vnoremap d h
vnoremap h j
vnoremap t k
vnoremap n l

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

# Instalar los plugins de Vim-Plug
Write-Info "Instalando plugins de Vim-Plug..."
vim -c "PlugInstall" -c "qa"

# Instalar la extensión coc-pyright para Python
Write-Info "Instalando extensión coc-pyright para coc.nvim..."
vim -c "CocInstall coc-pyright" -c "qa"

# Instalar paquetes de Python necesarios para ALE y Vimspector
Write-Info "Instalando paquetes de Python necesarios..."
python -m pip install --user flake8 black mypy autopep8 debugpy

# Informar al usuario sobre pasos adicionales
Write-Info "Instalación y configuración completadas exitosamente."

Write-Host "==============================================" -ForegroundColor Blue
Write-Host "|      Configuración de Vim Finalizada      |" -ForegroundColor Blue
Write-Host "==============================================" -ForegroundColor Blue
Write-Host "Para aplicar los cambios, reinicia Vim."
Write-Host "A continuación, puedes probar tu configuración con un archivo de ejemplo."
Write-Host "Ejecuta el siguiente comando para crear un archivo de prueba:"
Write-Host "    echo 'print(\"Hola, Mundo!\")' > $env:USERPROFILE\ejemplo.py"
Write-Host "Luego, abre Vim con el archivo de prueba:"
Write-Host "    vim $env:USERPROFILE\ejemplo.py"
