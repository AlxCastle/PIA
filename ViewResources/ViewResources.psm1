<#Description: The module is responsible for showing the user the memory, disk, process, and network resources,
You will also have the option to choose between viewing the resources used at the moment, or generating a text report.
Parameters: No input parameters are needed, however, data is requested inside the module.#>
function View-Resources{
#First, the resources used are obtained in variables.
#In this command, the counter is used that calls certain processes such as network, memory, cpu, tec. The properties are converted to numbers to make it easier to read.
#The try is used to be able to execute the command if the machine is in English or Spanish   
    try{
        $UsedRAM=Get-Counter "\memoria\% de bytes confirmados en uso" | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
        $FreeRAM=100-$UsedRam
        $UsedDisk=Get-Counter "\disco físico(_Total)\% de tiempo de disco" | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
        $FreeDisk=100-$UsedDisk
        $UsedCPU=Get-Counter "\Procesador(_Total)\% de tiempo de procesador" | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
        $FreeCPU=100-$UsedCPU
        $SentRed=Get-Counter "\Interfaz de red(*)\Bytes enviados/s" | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
        $ReceivedRed=Get-Counter "\Interfaz de red(*)\Bytes recibidos/s" | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
    }catch{
        try{
            $UsedRAM=Get-Counter "\Memory\% Committed Bytes In Use" | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
            $FreeRAM=100-$UsedRam
            $UsedDisk=Get-Counter "\PhysicalDisk(_Total)\% Disk Time" | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
            $FreeDisk=100-$UsedDisk
            $UsedCPU=Get-Counter "\Processor(_Total)\% Processor Time" | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
            $FreeCPU=100-$UsedCPU
            $SentRed=Get-Counter "\\Network Interface(*)\Bytes Sent/sec" | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
            $ReceivedRed=Get-Counter "\Network Interface(*)\Bytes Received/sec" | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
        }catch{
            Write-Host "No se pudieron obtener los recursos usados"
            break
        }
    }
#First, an option is read into a variable so that users can choose whether to view it at the moment or generate a report.    
    $op=Read-host "Presione [1]-Para ver los recursos utilizados [2]-Para generar un reporte de los recursos utilizados"
#It will be verified that there are no errors with the while
    while($op -ne 1 -and $op -ne 2){
        Write-Host "Elija una opcion correcta"
        $op= Read-Host "Presione [1]-Para ver los recursos utilizados [2]-Para generar un reporte de los recursos utilizados"
    }
#In the first option the processes will be shown instantly    
    if($op -eq 1){
        Write-Host "Este es el uso de memoria libre es $FreeRAM%"
        Write-Host "Este es el uso de memoria que se esta utilizando $UsedRAM%"
        Write-Host "Este es el uso de disco libre es $FreeDisk%"
        Write-Host "Este es el uso de disco que se esta utilizando $UsedDisk%"
        Write-Host "Este es el uso de CPU(procesos) libre es $FreeCPU%"
        Write-Host "Este es el uso de CPU(procesos) que se esta utilizando $UsedCPU%" 
        Write-Host "Esta es la cantidad de bytes que se estan enviando en la red $SentRed"
        Write-Host "Esta es la cantidad de bytes que se estan recibiendo en la red $ReceivedRed"
#Otherwise, the next option will ask for a path to follow along with the file name to save the report.  
    }else{
        $path=Read-Host "Ingrese la ruta en donde se guardara el archivo de texto"
        $NameFile=Read-Host "Ingrese el nombre del archivo junto con la extension -.txt-"
        $filepath=$path+$NameFile
#A try is used to verify that the route exists       
        try{
            Add-Content -path $filepath -value "Este es el uso de memoria libre $FreeRAM%"
            Add-Content -path $filepath -value "Este es el uso de memoria que se esta utilizando $UsedRAM%"
            Add-Content -path $filepath -value "Este es el uso de disco libre es $FreeDisk%"
            Add-Content -path $filepath -value "Este es el uso de disco que se esta utilizando $UsedDisk%"
            Add-Content -path $filepath -value "Este es el uso de CPU(procesos) libre $FreeCPU%"
            Add-Content -path $filepath -value "Este es el uso de CPU(procesos) que se esta utilizando $UsedCPU%" 
            Add-Content -path $filepath -value "Esta es la cantidad de bytes que se estan enviando en la red $SentRed"
            Add-Content -path $filepath -value "Esta es la cantidad de bytes que se estan recibiendo en la red $ReceivedRed"
        }catch{
            Write-Host "No se encontro la ruta"
        }
    }
}