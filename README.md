# **Treaty of Babel for Windows**  

I had zero luck with the included makefile, these are the steps I used to compile  

This does edit 3 source files:  

1st `hotload.c` I had to change line 56 (would not compile without changing)

| int babel_hotload(char *tdir, char *cdir, load_treaty hdlr, void *tctx, void *cctx) | to   | int main(char *tdir, char *cdir, load_treaty hdlr, void *tctx, void *cctx) |
| ------------------------------------------------------------ | ---- | ------------------------------------------------------------ |

The other 2 files are `treaty.h` & `babel.h`, only updated the version info 

| Version 0.5, Treaty of Babel Revision 10 | to   | Version 0.6, Treaty of Babel Revision 11 |
| ---------------------------------------- | ---- | ---------------------------------------- |

------

These commands will download the source files, install needed compilers, compile the perl files to exe and compile C files to EXE, place a zip file called babel_suite_win32.zip with all the EXE files on the Desktop

------

# **Instructions start here**  



I used a fresh install of Windows 10, I used the evaluation copy from here for VMware  
https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/  
The password to your VM is "Passw0rd!"    

------

If you use a normal ISO and install Windows that way you will also need to install Chocolatey (preinstalled on eval Windows) run THIS 1st in the Powershell Terminal.  You will also need to update the USERNAME in the commands below  

`Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))`  

**Start Powershell 5.1 TERMINAL as admin**  

`Invoke-WebRequest -Uri "https://babel.ifarchive.org/downloads/babel-0.6.zip" -OutFile "C:\Users\IEUser\babel-0.6.zip" #Change if not using EVAL version`  
`Expand-Archive -LiteralPath "C:\Users\IEUser\babel-0.6.zip" -DestinationPath "C:\Users\IEUser\babel-0.6" #Change if not using EVAL version`  
`Set-MpPreference -DisableRealtimeMonitoring $true # Makes it go faster`  
`choco feature enable -n allowGlobalConfirmation`  
`choco install strawberryperl`  

**RESTART POWERSHELL TERMINAL as admin**  

`cd C:\Users\IEUser\babel-0.6 #Change if not using EVAL version`  
`cpanm PAR::Packer #TAKES FOREVER`  
`refreshenv`  



`cd extras`  

`pp -x -o ..\babel-cache.exe babel-cache.pl`  
`pp -x -o ..\babel-infocom.exe babel-infocom.pl`  
`pp -x -o ..\babel-marry.exe babel-marry.pl`  
`pp -x -o ..\babel-wed.exe babel-wed.pl`  

`cd ..`  

`choco install make mingw upx`  
`refreshenv`  



`(Get-Content treaty.h) -Replace 'Version 0.5', 'Version 0.6' | Set-Content treaty.h`  
`(Get-Content treaty.h) -Replace '#define TREATY_COMPLIANCE "Treaty of Babel revision 10"', '#define TREATY_COMPLIANCE "Treaty of Babel revision 11"' | Set-Content treaty.h`  
`(Get-Content treaty.h) -Replace '#define TREATY_VERSION "r10"', '#define TREATY_VERSION "r11"' | Set-Content treaty.h`  

`(Get-Content babel.h) -Replace '#define BABEL_VERSION "0.5"', '#define BABEL_VERSION "0.6"' | Set-Content babel.h`  




`copy babel_handler.h extras/babel_handler.h`  
`copy ifiction.h extras/ifiction.h`  
`copy treaty.h extras/treaty.h`  

`copy babel_handler.h babel-get/babel_handler.h`  
`copy ifiction.h babel-get/ifiction.h`  
`copy treaty.h babel-get/treaty.h`  


`gcc -c adrift.c`  
`gcc -c advsys.c`  
`gcc -c agt.c`  
`gcc -c alan.c`  
`gcc -c babel.c`  
`gcc -c babel_handler.c`  
`gcc -c babel_ifiction_functions.c`  
`gcc -c babel_multi_functions.c`  
`gcc -c babel_story_functions.c`  
`gcc -c blorb.c`  
`gcc -c executable.c`  
`gcc -c glulx.c`  
`gcc -c html.c`  
`gcc -c hugo.c`  
`gcc -c ifiction.c`  
`gcc -c level9.c`  
`gcc -c magscrolls.c`  
`gcc -c md5.c`  
`gcc -c misc.c`  
`gcc -c register.c`  
`gcc -c register_ifiction.c`  
`gcc -c tads.c`  
`gcc -c tads2.c`  
`gcc -c tads3.c`  
`gcc -c zcode.c`  



`ar cr adrift.a adrift.o`  
`ar cr advsys.a advsys.o`   
`ar cr agt.a agt.o`   
`ar cr alan.a alan.o`   
`ar cr babel.a babel.o`   
`ar cr babel_handler.a babel_handler.o`   
`ar cr babel_ifiction_functions.a babel_ifiction_functions.o`   
`ar cr babel_multi_functions.a babel_multi_functions.o`   
`ar cr babel_story_functions.a babel_story_functions.o`   
`ar cr blorb.a blorb.o`   
`ar cr executable.a executable.o`   
`ar cr glulx.a glulx.o`   
`ar cr html.a html.o`   
`ar cr hugo.a hugo.o`   
`ar cr ifiction.a ifiction.o`   
`ar cr level9.a level9.o`   
`ar cr magscrolls.a magscrolls.o`   
`ar cr md5.a md5.o`   
`ar cr misc.a misc.o`   
`ar cr register.a register.o`   
`ar cr register_ifiction.a register_ifiction.o`   
`ar cr tads.a tads.o`   
`ar cr tads2.a tads2.o`   
`ar cr tads3.a tads3.o`   
`ar cr zcode.a zcode.o`   

`ar -r babel_functions.a babel_story_functions.o babel_ifiction_functions.o babel_multi_functions.o`  
`gcc -o babel babel.o babel_functions.a ifiction.a babel.a babel_handler.a md5.a blorb.a misc.a register_ifiction.a register.a executable.a zcode.a glulx.a tads2.a tads3.a hugo.a alan.a adrift.a level9.a agt.a magscrolls.a advsys.a html.a tads.a`  


`cd extras`  

`(Get-Content hotload.c) -Replace 'int babel_hotload', 'int main' | Set-Content hotload.c`  

`gcc -c babel-list.c`  
`gcc -c hotload.c`  
`gcc -c ifiction-aggregate.c`  
`gcc -c ifiction-xtract.c`  
`gcc -c simple-marry.c`  


`ar cr babel-list.a babel-list.o`  
`ar cr hotload.a hotload.o`  
`ar cr ifiction-aggregate.a ifiction-aggregate.o`  
`ar cr ifiction-xtract.a ifiction-xtract.o`  
`ar cr simple-marry.a simple-marry.o`  



`gcc -o ..\ifiction-xtract ifiction-xtract.o ..\ifiction.a ..\babel_handler.a ..\misc.a ..\register_ifiction.a ..\md5.a ..\register.a ..\glulx.a ..\html.a ..\hugo.a ..\magscrolls.a ..\tads2.a ..\tads3.a ..\zcode.a ..\agt.a ..\level9.a ..\alan.a ..\adrift.a ..\advsys.a ..\executable.a ..\blorb.a ..\tads.a`  
`gcc -o ..\ifiction-aggregate ifiction-aggregate.o ..\ifiction.a ..\babel_handler.a ..\misc.a ..\register_ifiction.a ..\md5.a ..\register.a ..\glulx.a ..\html.a ..\hugo.a ..\magscrolls.a ..\tads2.a ..\tads3.a ..\zcode.a ..\agt.a ..\level9.a ..\alan.a ..\adrift.a ..\advsys.a ..\executable.a ..\blorb.a ..\tads.a`  
`gcc -o ..\simple-marry simple-marry.o ..\ifiction.a ..\babel_handler.a ..\misc.a ..\register_ifiction.a ..\md5.a ..\register.a ..\glulx.a ..\html.a ..\hugo.a ..\magscrolls.a ..\tads2.a ..\tads3.a ..\zcode.a ..\agt.a ..\level9.a ..\alan.a ..\adrift.a ..\advsys.a ..\executable.a ..\blorb.a ..\tads.a`  
`gcc -o ..\babel-list babel-list.o ..\babel_handler.a ..\misc.a ..\md5.a ..\register.a ..\adrift.a ..\advsys.a ..\alan.a ..\blorb.a ..\executable.a ..\glulx.a ..\html.a ..\hugo.a ..\magscrolls.a ..\tads2.a ..\tads3.a ..\zcode.a ..\agt.a ..\level9.a ..\ifiction.a ..\tads.a ..\register_ifiction.a`  
`gcc -o ..\hotload hotload.o ..\ifiction.a ..\babel_handler.a ..\misc.a ..\register_ifiction.a ..\md5.a ..\register.a ..\glulx.a ..\html.a ..\hugo.a ..\magscrolls.a ..\tads2.a ..\tads3.a ..\zcode.a ..\agt.a ..\level9.a ..\alan.a ..\adrift.a ..\advsys.a ..\executable.a ..\blorb.a ..\tads.a`  

`cd ..`  


`cd babel-get`  

`gcc -c babel-get.c`  
`gcc -c get_dir.c`  
`gcc -c get_ifiction.c`  
`gcc -c get_story.c`  
`gcc -c get_url.c`  

`ar cr babel-get.a babel-get.o`  
`ar cr get_dir.a get_dir.o`  
`ar cr get_ifiction.a get_ifiction.o`  
`ar cr get_story.a get_story.o`  
`ar cr get_url.a get_url.o`  

`gcc -o ..\babel-get babel-get.o get_dir.a get_ifiction.a get_story.a get_url.a ..\ifiction.a ..\babel_handler.a ..\misc.a ..\register_ifiction.a ..\md5.a ..\register.a ..\glulx.a ..\html.a ..\hugo.a ..\magscrolls.a ..\tads2.a ..\tads3.a ..\zcode.a ..\agt.a ..\level9.a ..\alan.a ..\adrift.a ..\advsys.a ..\executable.a ..\blorb.a ..\tads.a`  
`cd ..`  
`upx -9 *.exe`  
`Compress-Archive -Path *.exe -DestinationPath C:\Users\IEUser\Desktop\babel_suite_win32.zip #Change if not using EVAL version`  
