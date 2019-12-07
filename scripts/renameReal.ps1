# run in directory containing files to rename
# name files to rename integers 1-...
function rename {
    param([string]$newNamesLocation, [string]$showTitle, [int]$seasonNumber)
    [array]$existingFiles = dir | Sort-Object -Property {$_.BaseName -as [int]}
    [array]$newNames = Get-Content -Path $newNamesLocation
    $baseFilename = "$showTitle - s"
        if ($seasonNumber -lt 10) {
            $baseFilename += "0"
        }
        $baseFilename += "$($seasonNumber)e"
    for ($i = 0; $i -lt $existingFiles.Count; $i++) {
        $existingExtension = ([System.IO.Path]::GetExtension($existingFiles[$i]))
        $newFilename = $baseFilename
        if ($i + 1 -lt 10) {
            $newFilename += "0"
        }
        $newFilename += "$($i+1) - $($newNames[$i])$existingExtension"
        Write-Host "Renaming: $($existingFiles[$i]); To: $newFilename"
        Rename-Item $existingFiles[$i] -NewName $newFilename
    }
    Write-Host "Renamed $($existingFiles.Count) files successfully"
}
# use dot sourcing to run function in powershell
# see: https://stackoverflow.com/questions/6016436/in-powershell-how-do-i-define-a-function-in-a-file-and-call-it-from-the-powersh