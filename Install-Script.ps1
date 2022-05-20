Set-MpPreference -DisableRealtimeMonitoring $true
Set-ExecutionPolicy Bypass -Scope Process -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-PackageProvider -Name NuGet -Force
Install-Module -Name tom42tools -Force -AllowClobber
Import-Module -Name tom42tools -Force

If ($env:ChocolateyInstall -eq $null){Install-Choco}
Switch-WindowsDefender -Disable
Set-Location -Path "c:\Users\$env:UserName"

Invoke-WebRequest -Uri "https://babel.ifarchive.org/downloads/babel-0.6.zip" -OutFile "C:\Users\$env:UserName\babel-0.6.zip" #Change if not using EVAL version
Expand-Archive -LiteralPath "C:\Users\$env:UserName\babel-0.6.zip" -DestinationPath "C:\Users\$env:UserName\babel-0.6" #Change if not using EVAL version
choco feature enable -n allowGlobalConfirmation
choco install strawberryperl

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
Set-Location -Path "c:\Users\$env:UserName\babel-0.6"

cpanm PAR::Packer #TAKES FOREVER
refreshenv
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
Set-Location -Path "c:\Users\$env:UserName\babel-0.6\extras"

pp -o ..\babel-cache.exe babel-cache.pl
pp -o ..\babel-infocom.exe babel-infocom.pl
pp -o ..\babel-marry.exe babel-marry.pl
pp -o ..\babel-wed.exe babel-wed.pl

Set-Location -Path "c:\Users\$env:UserName\babel-0.6"
choco install make mingw upx
refreshenv
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

(Get-Content treaty.h) -Replace 'Version 0.5', 'Version 0.6' | Set-Content treaty.h
(Get-Content treaty.h) -Replace '#define TREATY_COMPLIANCE "Treaty of Babel revision 10"', '#define TREATY_COMPLIANCE "Treaty of Babel revision 11"' | Set-Content treaty.h
(Get-Content treaty.h) -Replace '#define TREATY_VERSION "r10"', '#define TREATY_VERSION "r11"' | Set-Content treaty.h
(Get-Content babel.h) -Replace '#define BABEL_VERSION "0.5"', '#define BABEL_VERSION "0.6"' | Set-Content babel.h
Copy-Item babel_handler.h extras/babel_handler.h
Copy-Item ifiction.h extras/ifiction.h
Copy-Item treaty.h extras/treaty.h
Copy-Item babel_handler.h babel-get/babel_handler.h
Copy-Item ifiction.h babel-get/ifiction.h
Copy-Item treaty.h babel-get/treaty.h

gcc -c adrift.c
gcc -c advsys.c
gcc -c agt.c
gcc -c alan.c
gcc -c babel.c
gcc -c babel_handler.c
gcc -c babel_ifiction_functions.c
gcc -c babel_multi_functions.c
gcc -c babel_story_functions.c
gcc -c blorb.c
gcc -c executable.c
gcc -c glulx.c
gcc -c html.c
gcc -c hugo.c
gcc -c ifiction.c
gcc -c level9.c
gcc -c magscrolls.c
gcc -c md5.c
gcc -c misc.c
gcc -c register.c
gcc -c register_ifiction.c
gcc -c tads.c
gcc -c tads2.c
gcc -c tads3.c
gcc -c zcode.c

ar cr adrift.a adrift.o
ar cr advsys.a advsys.o
ar cr agt.a agt.o
ar cr alan.a alan.o
ar cr babel.a babel.o
ar cr babel_handler.a babel_handler.o
ar cr babel_ifiction_functions.a babel_ifiction_functions.o
ar cr babel_multi_functions.a babel_multi_functions.o
ar cr babel_story_functions.a babel_story_functions.o
ar cr blorb.a blorb.o
ar cr executable.a executable.o
ar cr glulx.a glulx.o
ar cr html.a html.o
ar cr hugo.a hugo.o
ar cr ifiction.a ifiction.o
ar cr level9.a level9.o
ar cr magscrolls.a magscrolls.o
ar cr md5.a md5.o
ar cr misc.a misc.o
ar cr register.a register.o
ar cr register_ifiction.a register_ifiction.o
ar cr tads.a tads.o
ar cr tads2.a tads2.o
ar cr tads3.a tads3.o
ar cr zcode.a zcode.o

ar -r babel_functions.a babel_story_functions.o babel_ifiction_functions.o babel_multi_functions.o
gcc -o babel babel.o babel_functions.a ifiction.a babel.a babel_handler.a md5.a blorb.a misc.a register_ifiction.a register.a executable.a zcode.a glulx.a tads2.a tads3.a hugo.a alan.a adrift.a level9.a agt.a magscrolls.a advsys.a html.a tads.a
Set-Location -Path "c:\Users\$env:UserName\babel-0.6\extras"
(Get-Content hotload.c) -Replace 'int babel_hotload', 'int main' | Set-Content hotload.c

gcc -c babel-list.c
gcc -c hotload.c
gcc -c ifiction-aggregate.c
gcc -c ifiction-xtract.c
gcc -c simple-marry.c

ar cr babel-list.a babel-list.o
ar cr hotload.a hotload.o
ar cr ifiction-aggregate.a ifiction-aggregate.o
ar cr ifiction-xtract.a ifiction-xtract.o
ar cr simple-marry.a simple-marry.o

gcc -o ..\ifiction-xtract ifiction-xtract.o ..\ifiction.a ..\babel_handler.a ..\misc.a ..\register_ifiction.a ..\md5.a ..\register.a ..\glulx.a ..\html.a ..\hugo.a ..\magscrolls.a ..\tads2.a ..\tads3.a ..\zcode.a ..\agt.a ..\level9.a ..\alan.a ..\adrift.a ..\advsys.a ..\executable.a ..\blorb.a ..\tads.a
gcc -o ..\ifiction-aggregate ifiction-aggregate.o ..\ifiction.a ..\babel_handler.a ..\misc.a ..\register_ifiction.a ..\md5.a ..\register.a ..\glulx.a ..\html.a ..\hugo.a ..\magscrolls.a ..\tads2.a ..\tads3.a ..\zcode.a ..\agt.a ..\level9.a ..\alan.a ..\adrift.a ..\advsys.a ..\executable.a ..\blorb.a ..\tads.a
gcc -o ..\simple-marry simple-marry.o ..\ifiction.a ..\babel_handler.a ..\misc.a ..\register_ifiction.a ..\md5.a ..\register.a ..\glulx.a ..\html.a ..\hugo.a ..\magscrolls.a ..\tads2.a ..\tads3.a ..\zcode.a ..\agt.a ..\level9.a ..\alan.a ..\adrift.a ..\advsys.a ..\executable.a ..\blorb.a ..\tads.a
gcc -o ..\babel-list babel-list.o ..\babel_handler.a ..\misc.a ..\md5.a ..\register.a ..\adrift.a ..\advsys.a ..\alan.a ..\blorb.a ..\executable.a ..\glulx.a ..\html.a ..\hugo.a ..\magscrolls.a ..\tads2.a ..\tads3.a ..\zcode.a ..\agt.a ..\level9.a ..\ifiction.a ..\tads.a ..\register_ifiction.a
gcc -o ..\hotload hotload.o ..\ifiction.a ..\babel_handler.a ..\misc.a ..\register_ifiction.a ..\md5.a ..\register.a ..\glulx.a ..\html.a ..\hugo.a ..\magscrolls.a ..\tads2.a ..\tads3.a ..\zcode.a ..\agt.a ..\level9.a ..\alan.a ..\adrift.a ..\advsys.a ..\executable.a ..\blorb.a ..\tads.a

Set-Location -Path "c:\Users\$env:UserName\babel-0.6\babel-get"   

gcc -c babel-get.c
gcc -c get_dir.c
gcc -c get_ifiction.c
gcc -c get_story.c
gcc -c get_url.c

ar cr babel-get.a babel-get.o
ar cr get_dir.a get_dir.o
ar cr get_ifiction.a get_ifiction.o
ar cr get_story.a get_story.o
ar cr get_url.a get_url.o

gcc -o ..\babel-get babel-get.o get_dir.a get_ifiction.a get_story.a get_url.a ..\ifiction.a ..\babel_handler.a ..\misc.a ..\register_ifiction.a ..\md5.a ..\register.a ..\glulx.a ..\html.a ..\hugo.a ..\magscrolls.a ..\tads2.a ..\tads3.a ..\zcode.a ..\agt.a ..\level9.a ..\alan.a ..\adrift.a ..\advsys.a ..\executable.a ..\blorb.a ..\tads.a

Set-Location -Path "c:\Users\$env:UserName\babel-0.6"
upx -9 *.exe
Compress-Archive -Path *.exe -DestinationPath "C:\Users\$env:UserName\Desktop\babel_suite_win32.zip" #Change if not using EVAL version
Set-MpPreference -DisableRealtimeMonitoring $false
Switch-WindowsDefender -Enable
