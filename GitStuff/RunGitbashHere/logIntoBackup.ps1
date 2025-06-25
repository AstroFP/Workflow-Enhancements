param(
    [string]$SystemPath,
    [string]$UserPath
)
Function New-Backup {
    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    Add-Content -Encoding UTF8 backupPath.txt "-------------"
    Add-Content -Encoding UTF8 backupPath.txt $date
    Add-Content -Encoding UTF8 backupPath.txt "SystemPath:"
    Add-Content -Encoding UTF8 backupPath.txt $SystemPath 
    Add-Content -Encoding UTF8 backupPath.txt "UserPath:"
    Add-Content -Encoding UTF8 backupPath.txt $UserPath
}

New-Backup
