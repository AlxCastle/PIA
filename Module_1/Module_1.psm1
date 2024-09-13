﻿
<#
.SYNOPSIS
Hashes de los archivos en una carpeta especificada.

.DESCRIPTION
Esta función recorre todos los archivos de una carpeta dada y calcula el hash de cada archivo 
usando el algoritmo predeterminado(SHA256). Mediante la Api VirusTotal realiza una consulta del estado 
de cada hashs obtenido.

.PARAMETER folderPath
La ruta completa de la carpeta de la cual se desean obtener los hashes de los archivos.

.PARAMETER apikey
La clave Api obtenida de la api VirusTotal al registrarse.

.EXAMPLE
Get-VirusTotalTest -folderPath C:\MisArchivos -apikey 9ab213bk4h1213...

.EXAMPLE
$information = Get-VirusTotalTest -folderPath C:\MisArchivos -apikey 9ab213bk4h1213...
$information es de tipo diccionario. 

.NOTES
Asegúrate de tener permisos de acceso a la carpeta, y verificar que la apikey no ha expirado para evitar errores.

#>

function Get-VirusTotalTest {
    param(
        [Parameter(Mandatory)][string]$folderPath = $(Read-Host "Ingresa la ruta de la carpeta: "),
        [Parameter(Mandatory)][string]$apiKey = $(Read-Host "Ingresa tu apikey: ")
    )

    $url = "https://www.virustotal.com/vtapi/v2/file/report"
    $algorithm = "SHA256"

    $verifyingPath = (Test-Path -Path $folderPath)

    if ($verifyingPath) {
        try {
            $listFiles = Get-ChildItem -Path $folderPath -File

            foreach ($file in $listFiles) {
                $hash = Get-FileHash -Path $file.FullName -Algorithm $algorithm 

                try {
                    $params = @{
                        apikey   = $apiKey
                        resource = $hash.Hash
                    }

                    $response = Invoke-RestMethod -Uri $url -Method Post -Body $params
                    Write-Host ("El archivo " + $file) -ForegroundColor Magenta

                    foreach ($info in $response.PSObject.Properties) {
                        Write-Host "$($info.Name): $($info.Value)"
                    }
                } catch {
                    Write-Error "Error al realizar la solicitud a la API de VirusTotal: $_" -ErrorAction Stop
                }
                Start-Sleep -Seconds 3
            }
        } catch {
            Write-Error "Error al obtener el hash de los archivos: $_" -ErrorAction Stop
        }
    } else {
        Write-Host "No existe la carpeta especificada." -ForegroundColor Yellow
    }
}

