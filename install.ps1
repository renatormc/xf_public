
function InstallUV {
   
    $commandExists = Get-Command uv -ErrorAction SilentlyContinue
    if (-not $commandExists) {
        Write-Host "'uv' command not found. Installing..."
    
        winget install --id=astral-sh.uv -e
    
        if (Get-Command uv -ErrorAction SilentlyContinue) {
            Write-Host "'uv' command installed successfully."
        }
        else {
            Write-Host "Failed to install 'uv' command."
            Exit 1
        }
    } 
}

function InstallRClone {
   
    $commandExists = Get-Command uv -ErrorAction SilentlyContinue
    if (-not $commandExists) {
        Write-Host "'rclone' command not found. Installing..."
    
        winget install --id=astral-sh.uv -e
    
        if (Get-Command uv -ErrorAction SilentlyContinue) {
            Write-Host "'rclone' command installed successfully."
        }
        else {
            Write-Host "Failed to install 'rclone' command."
            Exit 1
        }
    } 
}

function Get-Destination {
    param (
        [string]$DefaultPath = "${HOME}\.xf"
    )

    $userInput = Read-Host "Escolha uma pasta de destino (pressione Enter para usar o valor default: $DefaultPath)"

    if ([string]::IsNullOrWhiteSpace($userInput)) {
        $userPath = $DefaultPath
    } else {
        $userPath = $userInput
    }

    Write-Host "Using path: $userPath"
    return $userPath
}


function DownloadXF {
    $dest = Get-Destination
    $url = "https://raw.githubusercontent.com/renatormc/xf_public/main/repos.json"
    $jsonData = Invoke-RestMethod -Uri $url
    foreach ($item in $jsonData) {
       try{
          rclone sync "$item" "$dest" --progress
           return
       }catch{         
          continue
       }        
    }
}

InstallUV
InstallRClone
DownloadXF


