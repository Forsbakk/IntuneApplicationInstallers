$AdvInstConfig = $env:TEMP + "\AdvInstConfig.JSON"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Forsbakk/Intune-Application-Installers/advinstall/Continuous%20delivery%20for%20Intune/Custom%20Execution/config.json" -OutFile $AdvInstConfig
$AdvInstallers = Get-Content $AdvInstConfig | ConvertFrom-Json

function Install-AdvancedApplication {
    Param (
        [string]$Name,
        [psobject]$FilesToDwnload,
        [psobject]$Execution,
        [psobject]$Detection,
        [string]$wrkDir
    )
    foreach ($dwnload in $FilesToDwnload) {
        $dwnload = $dwnload | Select-Object -ExpandProperty URL
        Invoke-WebRequest -Uri $dwnload -OutFile $wrkDir
    }
}

Install-AdvancedApplication -Name $AdvInstallers.Soultion.Name -FilesToDwnload $AdvInstallers.Soultion.FilesToDwnload -wrkDir $AdvInstallers.Soultion.wrkDir