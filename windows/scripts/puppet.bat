IF "%PROVISIONER%" == "puppet" GOTO PUPPET
@ECHO Puppet installation being skipped...
GOTO END

:PUPPET
@ECHO Puppet installation commencing...

if not exist "C:\Windows\Temp\puppet.msi" (
  @ECHO Downloading Puppet MSI installer...
  powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://downloads.puppetlabs.com/windows/puppet-3.3.0.msi', 'C:\Windows\Temp\puppet.msi')" <NUL
)

@ECHO Installing Puppet with msiexec...
:: http://docs.puppetlabs.com/pe/latest/install_windows.html
msiexec /qn /i C:\Windows\Temp\puppet.msi /log C:\Windows\Temp\puppet.log

<nul set /p ".=;C:\Program Files (x86)\Puppet Labs\Puppet\bin" >> C:\Windows\Temp\PATH
set /p PATH=<C:\Windows\Temp\PATH
setx PATH "%PATH%" /m
@ECHO Installation Complete!

:END
