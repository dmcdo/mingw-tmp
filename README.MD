This repository exists mostly so I can get gcc/g++/make on the Florida Tech computers without having to use Cygwin.

The below Powershell command downloads & installs MinGW-w64 8.1.0 (POSIX, SEH) in the current user's home directory and updates the PATH.

```powershell
Invoke-WebRequest -OutFile $env:TEMP\release-posix-seh.7z -URI "https://github.com/dmcdo/mingw-w64-install-script/raw/master/x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z";Invoke-WebRequest -OutFile $env:TEMP\7zr.exe -URI "https://www.7-zip.org/a/7zr.exe";cmd /c "7zr.exe x $env:TEMP\release-posix-seh.7z -o$env:USERPROFILE\release-posix-seh -y";Remove-Item $env:TEMP\release-posix-seh.7z;Remove-Item $env:TEMP\7zr.exe;cmd /c "mklink /H $env:USERPROFILE\release-posix-seh\mingw64\bin\make.exe $env:USERPROFILE\release-posix-seh\mingw64\bin\mingw32-make.exe";$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment').path;$newpath = "$env:USERPROFILE\release-posix-seh\mingw64\bin;" + $oldpath;Set-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment' -Name PATH -Value $newpath;Write-Output "Done. Log out and log back in for the changes to take full effect."
```

You will need to log out and log back in to be able to use gcc/g++/etc. from cmd/powershell.

<hr/>

If you are using VSCode with the C/C++ extension, add the following to your `settings.json` file,
```json
"C_Cpp.default.compilerPath": "${userprofile}\\release-posix-seh\\mingw64\\bin\\g++.exe"
```
or use GUI:

![image](https://user-images.githubusercontent.com/40744272/187100794-4563412c-b0b4-40d9-999f-e0cbda72c0f6.png)
