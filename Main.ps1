$modulePath = "$PSScriptRoot\Modules"
Import-Module "$modulePath\Module_1.psm1"

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
                }
                3 {
                    Write-Host "Revisión de uso de recursos del sistema."
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
