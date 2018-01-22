#
#Install.ps1
#Installs EXE applications in Microsoft Intune
#11.01.2018
#JF;Horten kommune
#
$AppName = "Office Mix"
$Installer = "OfficeMix.Setup.exe"
$InstArgs = "firstrun=0 /quiet /norestart"
$appLocURL = "http://sublog.org/storage/OfficeMix.Setup.exe"
$wrkDir = $env:TEMP
$detection = Test-Path "C:\Program Files (x86)\Office Mix\OfficeMix.potx"
$Uninstaller = $wrkDir + "\" + $Installer
$UninstArgs = "/uninstall /quiet"
$Mode = "Install" #Install or Uninstall

#
#INSTALL MODE
#
If ($mode -eq "Install") {
    Write-Verbose "Starting installation script for $AppName"

    #
    #App detection
    #
    Write-Verbose "Detecting previous installations"

    #
    #Installation
    #
    If (!($detection)) {
        Write-Verbose "$AppName is not detected, starting install"

        Invoke-WebRequest -Uri $appLocURL -OutFile $wrkDir\$Installer
        Start-Process -FilePath $wrkDir\$Installer -ArgumentList $InstArgs -Wait
        Remove-Item -Path $wrkDir\$Installer -Force
    }

    #
    #Abort installation
    #
    Else {
        Write-Verbose "$AppName detected, will NOT install"
    }
}

#
#UNINSTALL MODE
#
elseif ($mode -eq "Uninstall") {
    Invoke-WebRequest -Uri $appLocURL -OutFile $Uninstaller

    If (Test-Path $Uninstaller) {
        Start-Process $Uninstaller -ArgumentList $UninstArgs -Wait
    }
    Else {
        Write-Verbose "Could not find uninstaller, aborting"
    }
}