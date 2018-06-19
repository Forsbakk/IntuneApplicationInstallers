$PowerShell = @(
    @{
        Name      = "Remove VNC from Start Menu"
        Command   = "Remove-Item -Path 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\TightVNC' -Recurse -Force"
        Detection = "[bool](!(Test-Path -Path `"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\TightVNC`"))"
    },
    @{
        Name      = "Remove MS Teams DesktopEdt"
        Command   = "Start-Process -FilePath 'C:\Users\Default\AppData\Local\Microsoft\Teams\Update.exe' -ArgumentList '--uninstall -s' -Wait; Remove-Item -Path 'C:\Users\Default\Desktop\Microsoft Teams.lnk' -Force; Remove-Item -Path 'C:\Users\Default\AppData\Local\Microsoft\Teams' -Recurse -Force; Remove-Item -Path 'C:\Users\Default\AppData\Local\SquirrelTemp' -Recurse -Force; Remove-Item -Path 'C:\Users\Default\AppData\Roaming\Microsoft\Teams' -Recurse -Force; Remove-Item -Path 'C:\Users\Default\AppData\Roaming\Microsoft\Teams' -Recurse -Force; Remove-Item -Path 'C:\Users\Default\AppData\Local\Microsoft\TeamsMeetingAddin' -Recurse -Force"
        Detection = "[bool](!(Test-Path -Path `"C:\Users\Default\AppData\Local\Microsoft\Teams\Update.exe`"))"
    },
    @{
        Name      = "Add Restart-Computer every night"
        Command   = "Unregister-ScheduledTask -TaskPath '\' -TaskName 'Nightly Reboot'; Register-ScheduledTask -Action (New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-Command Restart-Computer -Force') -Trigger (New-ScheduledTaskTrigger -Daily -At 09:00pm) -User 'SYSTEM' -RunLevel Highest -Settings (New-ScheduledTaskSettingsSet -DontStopIfGoingOnBatteries -DontStopOnIdleEnd -WakeToRun) -TaskName 'Nightly Rebootv0.2' -Description 'v0.2'"
        Detection = "[bool](Get-ScheduledTask -TaskName 'Nightly Rebootv0.2')"
    }
)
$PowerShell | ConvertTo-Json -Compress | Out-File config.json