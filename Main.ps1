Import-Module Module_1

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

#MENU
function Get-Menu {
    clear
    Write-Host "*** MENU ***" -ForegroundColor Green
    Write-Host "1. Revisión de hashes de archivos y consulta a la API de VirusTotal"
    Write-Host "2. Listado de archivos ocultos en una carpeta"
    Write-Host "3. Revisión de uso de recursos del sistema"
    Write-Host "4. Tarea adicional de ciberseguridad"
    Write-Host "5. Salir"
}


<#
.SYNOPSIS
Menú principal que realiza funciones de ciberseguridad.

.DESCRIPTION
Desglosa un menú que muestra 4 funciones en especifico de ciberseguridad, cada una de las cuales fueron importadas de un modulo.

.EXAMPLE
Use-Menu desglosa el menu y debes escoger una de las prosibles

.NOTES
Puedes obtener la ayuda de cada funcion desglosando Get-Help (nombre de la funcion). Los modulos se descargan en una de las carpetas de 
PowerShell ubicadas en la variable $env:PSModulePath.

#>

function Use-Menu {
    do {
        try {
            $opcion = 0
            Get-Menu
            $opcion = [int](Read-Host "Seleccione una opción")
            
            switch ($opcion) {
                1 {
                    Write-Host "Revisión de hashes de archivos y consulta a la API de VirusTotal."
                    Get-VirusTotalTest
                }
                2 {
                    Write-Host "Listado de archivos ocultos en una carpeta."
                    $path= Read-Host "Ingrese la ruta que desee ver los archivos ocultos"
                    Show-HiddenFiles -path $path
                }
                3 {
                    Write-Host "Revisión de uso de recursos del sistema."
                    View-Resources
                }
                4 {
                    Write-Host "Tarea adicional de ciberseguridad."
                }
                5 {
                    Write-Host "Saliendo..."
                    break
                }
                default {
                    Write-Host "Opción inválida, seleccione una opción válida." -ForegroundColor Red
                }
            }
        } catch {
            Write-Host "Opción inválida, ingresa un número entero válido." -ForegroundColor Red
        }
        pause
    } while ($opcion -ne 5)
}

Use-Menu
