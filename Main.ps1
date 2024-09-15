# Get the path of the current directory of the script
$modulePath = $PSScriptRoot
# Import the modules by specifying the full path
Import-Module "$modulePath\Module_1\Module_1.psm1"
Import-Module "$modulePath\Module_2\Module_2.psm1"
Import-Module "$modulePath\Module_3\Module_3.psm1"
Import-Module "$modulePath\Module_4\Module_4.psm1"

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

#MENU
function Get-Menu {
    clear
    Write-Host "*** MENU ***" -ForegroundColor Green
    Write-Host "1. Revisión de hashes de archivos y consulta a la API de VirusTotal"
    Write-Host "2. Listado de archivos ocultos en una carpeta"
    Write-Host "3. Revisión de uso de recursos del sistema"
    Write-Host "4. Ver permisos de las carpetas (Tarea adicional de ciberseguridad"
    Write-Host "5. Salir"
}


<#
.SYNOPSIS
Main menu that performs cybersecurity functions.

.DESCRIPTION
Displays a menu that shows 4 specific cybersecurity functions, each of which was imported from a module.

.EXAMPLE
Use-Menu displays the menu, and you need to choose one of the available options.

.NOTES
You can obtain the help for each function by using Get-Help (function name). The modules are downloaded into one of the folders in
PowerShell located in the $env:PSModulePath variable.
To use them in this script, we import them by defining the script path with PSScriptRoot and then use that path to import them correctly.

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
                    Write-Host "Ver permisos de las carpetas (Tarea adicional de ciberseguridad)"
                    $opcion_Module4= Read-Host "Elige la opción a realizar: 1-Ver permisos de una carpeta en específico 2-Comparar permisos entre dos carpetas"
                    if( $opcion_Module4 -eq 1){
                        $path= Read-Host "Ingrese la ruta de la carpeta que desea ver sus permisos"
                        Show-Permissions -FolderPath $path
                        } elseif ( $opcion_Module4 -eq 2){
                            $path = Read-Host "Ingrese la ruta de la primera carpeta"
                            $path_2 = Read-Host "Ingrese la ruta de la segunda carpeta"
                            Compare-Permissions -Folder1 $path -Folder2 $path_2                    
                        } else{
                            Write-Host "Opción no válida, vuelve a intentarlo"
                                }
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
