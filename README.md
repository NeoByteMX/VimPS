# Configuración Automática de Vim para Desarrollo en Python3 con Soporte para Teclado Dvorak

Este script automatiza la instalación y configuración de **Vim** con una serie de plugins esenciales para el desarrollo en **Python3**, optimizando el entorno de desarrollo para usuarios de teclado **Dvorak**. Incluye la instalación de **Vim-Plug**, configuración de plugins para autocompletado, linting, formateo, snippets, navegación, integración con Git, depuración y manejo de entornos virtuales.

## Tabla de Contenidos

- [Características](#características)
- [Prerequisitos](#prerequisitos)
- [Instalación](#instalación)
- [Uso](#uso)
- [Verificación](#verificación)
- [Configuraciones Adicionales](#configuraciones-adicionales)
- [Solución de Problemas](#solución-de-problemas)
- [Contribuciones](#contribuciones)
- [Licencia](#licencia)

## Características

- **Instalación de Vim y Dependencias:** Automatiza la instalación de Vim, `curl`, `fzf`, Node.js, y `pip3`.
- **Gestión de Plugins con Vim-Plug:** Descarga e instala Vim-Plug para gestionar plugins de manera eficiente.
- **Plugins Esenciales para Python3:**
  - **Autocompletado y Soporte de Lenguaje:** `coc.nvim`
  - **Linting y Formateo:** `ALE` con `flake8`, `black`, `mypy`, y `autopep8`
  - **Snippets:** `UltiSnips` y `vim-snippets`
  - **Navegación y Exploración:** `fzf.vim`
  - **Integración con Git:** `vim-fugitive`
  - **Depuración:** `Vimspector`
  - **Manejo de Entornos Virtuales:** `vim-virtualenv`
- **Configuraciones Personalizadas:**
  - **Remapeo de Navegación para Teclado Dvorak**
  - **Configuraciones específicas para cada plugin**
- **Instalación de Extensiones y Paquetes de Python:** `coc-pyright`, `debugpy`, y paquetes necesarios para `ALE`.

## Prerequisitos

Antes de ejecutar el script, asegúrate de tener lo siguiente:

- **Sistema Operativo:** Windows.
- **Acceso a Internet:** Para descargar paquetes y plugins.
- **Permisos de Sudo:** Para instalar paquetes del sistema.
- **Python3 y pip3:** Instalados en el sistema.

## Instalación

1. Abre powershell ISE como administrador.
2. Selecciona Nuevo script
3. Copia el script vim.ps1
4. Selecciona ejecutar script (f5)


![image](https://github.com/user-attachments/assets/b9992b22-1205-4fde-a0ae-f24ebf4794d7)



## Verificación
Después de la instalación, es crucial verificar que todo funcione correctamente:

**Reiniciar Vim:**

Cierra y vuelve a abrir Vim para aplicar todos los cambios.

**Verificar Plugins Instalados:**

Dentro de Vim, ejecuta:
```
  :PlugStatus
```

Asegúrate de que todos los plugins estén instalados y no muestren errores.

## Probar Funcionalidades:

Autocompletado: Abre un archivo Python y prueba el autocompletado.
Linting: Introduce errores de sintaxis y verifica que ALE los resalte.
Formateo: Guarda el archivo y observa cómo black formatea el código.
Snippets: Prueba la expansión de snippets con <Tab>.
Navegación: Usa <C-p> para buscar y abrir archivos rápidamente.
Git: Ejecuta :Gstatus para interactuar con Git.
Depuración: Configura y prueba una sesión de depuración con Vimspector.
Entornos Virtuales: Activa y desactiva entornos virtuales usando los mapeos definidos.
Configuraciones Adicionales
Puedes personalizar aún más tu entorno de Vim agregando configuraciones adicionales al archivo .vimrc. Algunas recomendaciones incluyen:

**Cambiar el Leader Key:**

Por defecto, <leader> está mapeado a \. Puedes cambiarlo agregando al inicio de tu .vimrc:

let mapleader = ","

Esto te permitirá usar ,ev y ,ed para gestionar entornos virtuales.

**Agregar Más Extensiones a coc.nvim:**
```
  :CocInstall coc-json coc-html coc-css
```

**Personalizar Snippets:**

Agrega tus propios snippets en ~/.vim/UltiSnips/python.snippets para adaptarlos a tus necesidades.

## Solución de Problemas
**1. Autocompletado no Funciona:**
Verifica que coc-pyright esté instalado:
```
  :CocInstall coc-pyright
```

Asegúrate de que Node.js esté correctamente instalado:
```
  node -v
```

2. ALE No Muestra Errores de Linting:

Verifica que los linters estén instalados:
```
  pip3 install flake8 mypy
```

Revisa la configuración de ALE en .vimrc para asegurarte de que están correctamente definidos.

3. Snippets No se Expanden:
Asegúrate de que UltiSnips esté instalado y configurado correctamente.
Verifica que estás utilizando el trigger correcto (<Tab> por defecto).
Comprueba si hay conflictos de mapeo de teclas en tu .vimrc.

4. Vimspector No Inicia la Depuración:
Verifica que debugpy esté instalado:

```
pip3 install debugpy
```
Asegúrate de haber configurado correctamente los adaptadores en Vimspector.

Consulta la documentación de Vimspector para configuraciones avanzadas.

Contribuciones
¡Las contribuciones son bienvenidas! Si encuentras algún error, tienes una sugerencia o deseas agregar una nueva funcionalidad, por favor abre un issue o un pull request en el repositorio.

Licencia
Este proyecto está licenciado bajo la MIT License.

¡Gracias por usar este script para configurar tu entorno de Vim para Python3! Si tienes alguna pregunta o necesitas asistencia adicional, no dudes en contactarme.
