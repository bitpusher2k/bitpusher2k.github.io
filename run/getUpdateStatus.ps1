#           Bitpusher
#            \`._,'/
#            (_- -_)
#              \o/
#          The Digital
#              Fox
#          @VinceVulpes
#    https://theTechRelay.com
# https://github.com/bitpusher2k
#
# getUpdateStatus.ps1 - By Bitpusher/The Digital Fox
# v1.1 last updated 2022-10-25
# Script to install PSWindowsUpdate package (if needed)
# then query Windows for current update settings,
# available updates, and update history.
#
# Outputs a log to C:\Temp\HOSTNAME-UpdateStatus-DATESTAMP.txt
#
#get #windows #update #status #history #script #powershell #pswindowsupdate

$ComputerName = get-content env:computername
$logFilePath = "C:\Temp\$($env:computername)-UpdateStatus-$($(Get-Date).ToString("yyyyMMddhhmm")).txt"

if (Get-Module -ListAvailable -Name PSWindowsUpdate) {
    Write-Output "PSWindowsUpdate already installed. Continuing." | Tee-Object -FilePath $logFilePath -Append
} 
else {
    Write-Output "PSWindowsUpdate not installed. Installing..." | Tee-Object -FilePath $logFilePath -Append
	Install-PackageProvider -Name NuGet -Force
	Install-Module PSWindowsUpdate -Confirm:$False -Force
	Write-Output "`nModule installed. Continuing." | Tee-Object -FilePath $logFilePath -Append
}

Write-Output "`nGathering Windows Update information..." | Tee-Object -FilePath $logFilePath -Append

Write-Output $ComputerName | Tee-Object -FilePath $logFilePath -Append
Write-Output "`nUpdate sources:" | Tee-Object -FilePath $logFilePath -Append
Get-WUServiceManager | Tee-Object -FilePath $logFilePath -Append
Write-Output "`nUpdate settings:" | Tee-Object -FilePath $logFilePath -Append
Get-WUSettings | Tee-Object -FilePath $logFilePath -Append
Write-Output "`nCurrently available updates for this endpoint:" | Tee-Object -FilePath $logFilePath -Append
Show-WindowsUpdate -Confirm:$False | Tee-Object -FilePath $logFilePath -Append
Get-WindowsUpdate | Tee-Object -FilePath $logFilePath -Append
Write-Output "`nUpdate history:" | Tee-Object -FilePath $logFilePath -Append
Get-WUHistory | Tee-Object -FilePath $logFilePath -Append

Write-Output "Windows update information has been saved to $LogFile"
Write-Output "Done!"
