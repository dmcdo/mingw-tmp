Invoke-WebRequest -OutFile $env:TEMP\release-win32-seh.7z -URI "https://github.com/dmcdo/mingw-w64-install-script/raw/master/x86_64-8.1.0-release-win32-seh-rt_v6-rev0.7z"
Invoke-WebRequest -OutFile $env:TEMP\7zr.exe -URI "https://www.7-zip.org/a/7zr.exe"
cmd /c "`"$env:TEMP\7zr.exe`" x $env:TEMP\release-win32-seh.7z -o$env:USERPROFILE\release-win32-seh -y"
Remove-Item $env:TEMP\release-win32-seh.7z
Remove-Item $env:TEMP\7zr.exe
cmd /c "mklink /H $env:USERPROFILE\release-win32-seh\mingw64\bin\make.exe $env:USERPROFILE\release-win32-seh\mingw64\bin\mingw32-make.exe"
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment').path
$newpath = "$env:USERPROFILE\release-win32-seh\mingw64\bin;" + $oldpath
Set-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment' -Name PATH -Value $newpath
Write-Output "Done. Log out and log back in for the changes to take full effect."
