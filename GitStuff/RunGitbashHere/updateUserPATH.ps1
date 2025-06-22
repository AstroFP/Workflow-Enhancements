param(
    [string]$NewVariable
)
Function Set-PATHVariable {
    $userPATH = [System.Environment]::GetEnvironmentVariable("PATH","User")
    if ($userPATH -and $userPATH[-1] -ne ';') {
        #for some reason my path had a ";" at the end
        #but im pretty sure its not typical so im appending ";" just in case
        $userPATH += ';'
    }

    $newPATH = $userPATH + $NewVariable 
    [System.Environment]::SetEnvironmentVariable('PATH',$newPATH,'User')

    # checking if the variable got changed correctly
    $checkPATH = [System.Environment]::GetEnvironmentVariable('PATH', 'User')
    if ($checkPATH -eq $newPATH) {
        Write-Host "====SUCCESS===="
    } else {
        Write-Host "====FAILED===="
        Write-Host "Restoring the old PATH variable..."
        [System.Environment]::SetEnvironmentVariable('PATH',$userPATH,'User')
    }
}

Set-PATHVariable
