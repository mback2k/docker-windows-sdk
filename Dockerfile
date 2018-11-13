# escape=`

ARG BASE_TAG=1803

FROM mback2k/windows-base:${BASE_TAG}

SHELL ["powershell", "-command"]

RUN Invoke-WebRequest "https://go.microsoft.com/fwlink/p/?linkid=870807" -OutFile "C:\Windows\Temp\winsdksetup.exe"; `
    Start-Process -FilePath "C:\Windows\Temp\winsdksetup.exe" -ArgumentList /Quiet, /NoRestart -NoNewWindow -PassThru -Wait; `
    Remove-Item @('C:\Windows\Temp\*', 'C:\Users\*\Appdata\Local\Temp\*') -Force -Recurse; `
    Write-Host 'Checking INCLUDE ...'; `
    Get-Item -Path 'C:\Program Files (x86)\Windows Kits\10\Include\10.0.17134.0\shared'; `
    Get-Item -Path 'C:\Program Files (x86)\Windows Kits\10\Include\10.0.17134.0\um'; `
    Get-Item -Path 'C:\Program Files (x86)\Windows Kits\10\Include\10.0.17134.0\ucrt';

RUN Write-Host 'Updating INCLUDE ...'; `
    $env:INCLUDE = 'C:\Program Files (x86)\Windows Kits\10\Include\10.0.17134.0\shared;' + $env:INCLUDE; `
    $env:INCLUDE = 'C:\Program Files (x86)\Windows Kits\10\Include\10.0.17134.0\um;' + $env:INCLUDE; `
    $env:INCLUDE = 'C:\Program Files (x86)\Windows Kits\10\Include\10.0.17134.0\ucrt;' + $env:INCLUDE; `
    [Environment]::SetEnvironmentVariable('INCLUDE', $env:INCLUDE, [EnvironmentVariableTarget]::Machine);

CMD ["powershell"]
