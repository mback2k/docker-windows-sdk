# escape=`

ARG BASE_TAG=1709

FROM microsoft/windowsservercore:${BASE_TAG}

SHELL ["powershell", "-command"]

RUN Invoke-WebRequest "https://go.microsoft.com/fwlink/?linkid=859886" -OutFile "C:\winsdksetup.exe"; `
    Start-Process -FilePath "C:\winsdksetup.exe" -ArgumentList /Quiet, /NoRestart -NoNewWindow -PassThru -Wait; `
    Remove-Item "C:\winsdksetup.exe";

RUN Write-Host 'Updating INCLUDE ...'; `
    $env:INCLUDE = 'C:\Program Files (x86)\Windows Kits\10\Include\10.0.16299.0\shared;' + $env:INCLUDE; `
    $env:INCLUDE = 'C:\Program Files (x86)\Windows Kits\10\Include\10.0.16299.0\um;' + $env:INCLUDE; `
    $env:INCLUDE = 'C:\Program Files (x86)\Windows Kits\10\Include\10.0.16299.0\ucrt;' + $env:INCLUDE; `
    [Environment]::SetEnvironmentVariable('INCLUDE', $env:INCLUDE, [EnvironmentVariableTarget]::Machine);

CMD ["powershell"]
