# run in directory containing files to rename
function moveFilesToDir {
    dir | ForEach {
        $_ | Move-Item -Destination $(md $_.BaseName)
    }
}