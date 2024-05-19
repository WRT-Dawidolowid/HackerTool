@echo off
set htv=2.32
title HackerTool %htv%
if "%1"=="welcome" goto welcome
:start
ping -n 1 github.com >nul
cls
if %errorlevel% == 1 goto nn
if %errorlevel% == 0 goto procnex

:nn
color 0c
echo HackerTool cannot proceed without a network connection! Connect to a network and try again.
pause >nul
exit

:skip
echo Loading skipped.
goto noproxy

:foldernotcreated
color 0c
echo HackerTool cannot proceed without a HackerTool folder.
echo To create a folder press C for exit press X
choice /n /c:cx /m:"Choice: "
if %errorlevel%==2 exit
if %errorlevel%==1 goto createfolder
exit

:createfolder
set cdthen=%cd%
cd C:\Users\%username%\AppData\Roaming
md HackerTool
cd %cdthen%
color 07
goto procnex

:procnex
if not exist C:\Users\%username%\AppData\Roaming\HackerTool goto foldernotcreated
setlocal enabledelayedexpansion
echo Checking Management...
certutil -split -urlcache -f "https://raw.githubusercontent.com/WRT-Dawidolowid/HackerTool/main/HackerToolManagement.inf" C:\Users\%username%\AppData\Local\Temp\HackerToolManagement.inf >nul
findstr /c:"maintenance=yes" "C:\Users\%username%\AppData\Local\Temp\HackerToolManagement.inf" >nul
if %errorlevel% == 0 goto maintenance
if not %errorlevel% == 0 goto continue
exit
:maintenance
title Maintenance
echo Sorry, but there is a Maintenance at this point.
choice /c:i /n
ipconfig /all | find "6A-54-5A-67-AC-23" >nul
if not %errorlevel% == 1 goto continue
exit
:continue
:ign
setlocal enabledelayedexpansion
if exist C:\Users\%username%\AppData\Local\Temp\UpdateInfo.inf goto conti2
del C:\Users\%username%\AppData\Local\Temp\UpdateInfo.inf /s /q >nul 2>&1
:conti2
if exist C:\Users\%username%\AppData\Local\Temp\HackerToolManagement.inf goto conti3
del C:\Users\%username%\AppData\Local\Temp\HackerToolManagement.inf /s /q >nul 2>&1
:conti3
echo Loading HackerTool...
for /f "delims=" %%i in ('curl.exe -s https://ipinfo.io/ip') do set "public_ip=%%i"
for /f "delims=" %%o in ('curl.exe -s "http://ip-api.com/json/?fields=proxy"') do set "proxy=%%o"
if "!proxy!"=="{"proxy":false}" set proxy=False
if "!proxy!"=="{"proxy":true}" set proxy=True
if %proxy%==True goto proxydet
if %proxy%==False goto noproxy
exit
:proxydet
title Proxy/VPN Detected
echo You are using VPN or Proxy. Please disconnect from VPN or Proxy to use HackerTool
echo If the message appears again, create a ticket on Movement Studio!
:2
pause >nul
goto 2
:noproxy
set "backip=!public_ip!"
echo Checking BlackList...
if !public_ip!==46.148.3.245 goto blacklist
echo Checking for Updates...
certutil -split -urlcache -f "https://raw.githubusercontent.com/WRT-Dawidolowid/HackerTool/main/UpdateInfo.inf" C:\Users\%username%\AppData\Local\Temp\UpdateInfo.inf >nul
set "counter=1"
for /f "tokens=*" %%a in ('type "C:\Users\%username%\AppData\Local\Temp\UpdateInfo.inf"') do (
    if !counter! equ 2 (
        set "versionid=%%a"
        goto update
    )
    set /a "counter+=1"
)

:update
if %versionid%==HackerTool-%htv% goto updatec
if not %versionid%==HackerTool-%htv% goto insupd
exit


:setnot
set htl=Basic
set dashboard=dashboard
goto login




:updatec
echo Your HackerTool version is up to date.
:premcheck
:prem
cd C:\Users\%username%\AppData\Roaming
if exist HackerTool goto existprem
if not exist HackerTool goto createprem
exit
:existprem
echo Checking settings...
if not exist C:\Users\%username%\AppData\Roaming\HackerTool\colors.txt goto skipcolorcheck
for /f "tokens=1,2 delims== " %%a in (C:\Users\%username%\AppData\Roaming\HackerTool\colors.txt) do (
    set %%a=%%b
)

if defined background (
    color !background!
)
:skipcolorcheck

if not exist C:\Users\%username%\AppData\Roaming\HackerTool\ipdisplaying.txt goto skipipdisplaycheck
for /f "tokens=1,2 delims== " %%a in (C:\Users\%username%\AppData\Roaming\HackerTool\ipdisplaying.txt) do (
    set %%a=%%b
)

if defined displayip (
    if "!displayip!"=="false" goto setip
)
goto skipipdisplaycheck
:setip
set "public_ip=Hidden"
:skipipdisplaycheck
:skipcol
set dashboard=premdash
title HackerTool %htv%
set htl=Premium

:login
:: echo.
:: if not "%1"=="" goto check
:: echo HackerTool %htv%
:: echo Enter password to access Program Selector!
:: echo.
:: set /p password= "CP-Pass >>"
:: if "%password%"=="" goto blank
:: if "%password%"=="%username%-%PROCESSOR_ARCHITECTURE%-%NUMBER_OF_PROCESSORS%"
goto select
goto blank
exit
:select
title HackerTool %htv%
:: echo =========================================
:: echo Program Selector
:: echo =========================================
:: echo (1) HackerTool [Multi Tool]
:: echo (2) Options (Discontinued)
:: echo =========================================
:: choice /n /c:12 /m:"Choice: "
:: if %errorlevel% == 1 goto %dashboard%
:: if %errorlevel% == 2 goto optionsnew
:: if %errorlevel% == 3 goto sibo
goto premdash
:blank
echo Password is empty or you typed incorrect password!
echo.
echo Restart HackerTool to retype password.
:loop1
pause >nul
goto loop1

:premdash
echo.
echo =========================================
echo HackerTool Version: %htv%
echo Your IP: !public_ip!
echo =========================================
echo (1) Geolocation System
echo (2) Ping Address
echo (3) Proxy Check
echo (4) PaySafeCard
echo (5) Random Number
echo (6) String Search
echo (7) Domain Converter
echo (8) API Connection
echo =========================================
echo (S) Settings
echo (A) About HackerTool
echo (R) Restart HackerTool
echo =========================================
:choiceprem
choice /n /c:12345ASD678R /m:"Choice: "
if %errorlevel% == 1 goto geo
if %errorlevel% == 2 goto ping
if %errorlevel% == 3 goto proxy
if %errorlevel% == 4 goto pscgen
if %errorlevel% == 5 goto randomnum
if %errorlevel% == 6 goto about
if %errorlevel% == 7 goto settings
if %errorlevel% == 8 goto devstar
::if %errorlevel% == 9 goto select
if %errorlevel% == 9 goto stringsearch
if %errorlevel% == 10 goto domainconvert
if %errorlevel% == 11 goto apicon
if %errorlevel% == 12 goto start
exit
:apicon
echo =========================================
echo API Connection
echo =========================================
echo (1) Manual connection
echo (2) Connection from json file
echo (R) Return
echo =========================================
choice /n /c:2R1 /m:"Choice: "
if %errorlevel% == 3 goto manualcon
if %errorlevel% == 1 goto conjson
if %errorlevel% == 2 goto clsdash
exit
:manualcon
echo Choose method:
echo [P] Post
echo [G] Get
echo [R] Return
choice /n /c:PGR /m:"Choice: "
if %errorlevel% == 1 set manualmeth=POST
if %errorlevel% == 2 set manualmeth=GET
if %errorlevel% == 3 goto clsdash
echo Please enter the content for this connection (Optional)
set /p content=">>"
echo.
echo Please enter the url for this connection
set /p url=">>"
cd "C:\Program Files\Movement Studio\HackerTool"
powershell -file HackerToolAPIConnectionManual.ps1 %url% %manualmeth% %content%
:conjson
:: JSON Format is on GitHub under the 2.3 release
:jsonenter
set /p "json= JSON File Path: 
if "%json%"=="" goto jsonenter
cd "C:\Program Files\Movement Studio\HackerTool"
powershell -file HackerToolAPIConnectionManual.ps1 %url% %manualmeth% '{"key": "%content%"}'

echo.
goto apicon

:domainconvert
echo =========================================
echo Domain Converter
echo =========================================
echo (1) Convert
echo (R) Return
echo =========================================
choice /n /c:1R /m:"Choice: "
if %errorlevel% == 1 goto convert
if %errorlevel% == 2 goto clsdash
exit
:convert
set /p domain= "Enter domain to convert: "
if "%domain%"=="" failedconv
echo Requesting server address...
echo =========================================
echo Domain: %domain%
nslookup %domain% | find "Address:"
echo =========================================
goto domainconvert
:failedconv
echo Converting failed (Non-existent domain)
goto domainconvert
:stringsearch
echo =========================================
echo String Search
echo =========================================
echo (1) Search
echo (2) Search and save
echo (R) Return
echo =========================================
choice /n /c:1R2 /m:"Choice: "
if %errorlevel% == 1 goto search
if %errorlevel% == 2 goto clsdash
if %errorlevel% == 3 goto searchsave
exit
:search
set fpath=
set string=
set /p fpath= "File path: "
set /p string= "Search for: "
if not exist "%fpath%" goto ssnf
type %fpath% | find "%string%"
if %errorlevel% == 1 goto stringsearcherror
echo.
echo Press any key to continue
pause >nul
goto stringsearch

:searchsave
set fpath=
set string=
set saveto=
set /p fpath= "File path: "
set /p string= "Search for: "
set /p saveto= "Save to: "
if not exist "%fpath%" goto ssnf
type %fpath% | find "%string%" >>%saveto%
echo.
echo Press any key to continue
pause >nul
goto stringsearch

:stringsearcherror
echo No entries found
goto stringsearch

:ssnf
echo Targeted file not found!
goto stringsearch




:randomnum
echo =========================================
echo Random Number
echo =========================================
echo (1) Start Generating
:: echo (2) Start Generating (To file)
echo (R) Return
echo =========================================
choice /n /c:1R /m:"Choice: "
if %errorlevel% == 1 goto gennum
if %errorlevel% == 2 goto clsdash
if %errorlevel% == 3 goto gennumfil
exit
:gennum
set /p low= "Lower limit: "
set /p up= "Upper limit: "
set /p batch_size= "How many numbers you want: "

for /L %%i in (1, 1, %batch_size%) do (
    set /a "random_number=%low% + !random! %% (%up% - %low% + 1)"
    echo !random_number!
)
goto randomnum

:gennumfil
set /p low= "Lower limit: "
set /p up= "Upper limit: "
set /p batch_size= "How many numbers you want: "
start /wait "C:\Program Files\Movement Studio\HackerTool\Folder"

for /L %%i in (1, 1, %batch_size%) do (
    set /a "random_number=%low% + !random! %% (%up% - %low% + 1)"
    echo !random_number!
)
goto randomnum

:devstar
set pass=
set /p pass= "DO-Pass >>"
if "%pass%"=="" goto clsdash
if %pass% == KSSP13%NUMBER_OF_PROCESSORS% goto devopt
if not %pass% == KSSP13%NUMBER_OF_PROCESSORS% goto clsdash
:proxy
set ip=
echo =========================================
echo Proxy Checker
echo =========================================
echo (I) Enter IP
echo (R) Return
echo =========================================
choice /n /c:RI /m:"Choice: "
if %errorlevel% == 1 goto clsdash
set /p ip= IP: 
if "%ip%"=="" goto emptyproxy
if not "%ip%"=="" goto checkproxy
exit
:emptyproxy
echo IP Cannot be empty!
echo.
goto proxy
:checkproxy
for /f "delims=" %%o in ('curl.exe -s "http://ip-api.com/json/%ip%?fields=proxy"') do set "proxy=%%o"
if "!proxy!"=="{"proxy":false}" set proxy=False
if "!proxy!"=="{"proxy":true}" set proxy=True
if "!proxy!"=="{}" goto errorproxy
goto output
:errorproxy
echo IP Is incorrect!
echo.
goto proxy
:output
echo =========================================
echo IP : %ip%
echo Proxy: %proxy%
echo =========================================
echo.
pause >nul
goto proxy

:pscgen
echo =========================================
echo PaySafeCard Generator
echo =========================================
echo (S) Start Generating (Infnity)
echo (A) Start Generating
echo (R) Return
echo =========================================
choice /n /c:RSA /m:"Choice: "
if %errorlevel% == 1 goto clsdash
if %errorlevel% == 2 goto infpscgen
if %errorlevel% == 3 goto startgen
exit
:startgen
set /p repeats= "How many keys you want: " 
set /a counter=0
set /a rem=%repeats%
:repeat2
if %counter%==%repeats% goto endpsc
if not %counter%==%repeats% goto next
exit
:next
set /a counter=%counter%+1
set /a rem=%rem%-1
set "random_number="
for /l %%i in (1,1,16) do (
    set /a "digit=!random! %% 10"
    set "random_number=!random_number!!digit!"
)
set "formatted_number=!random_number:~0,4!-!random_number:~4,4!-!random_number:~8,4!-!random_number:~12,4!"
echo %formatted_number% (Remaining: %rem%)
goto repeat2
:endpsc
goto pscgen
:infpscgen
set "random_number="
for /l %%i in (1,1,16) do (
    set /a "digit=!random! %% 10"
    set "random_number=!random_number!!digit!"
)
set "formatted_number=!random_number:~0,4!-!random_number:~4,4!-!random_number:~8,4!-!random_number:~12,4!"
echo %formatted_number%
goto infpscgen
:settings
cls
echo =========================================
echo HackerTool Settings
echo =========================================
:: echo (1) Security
echo (1) Appearance
echo (2) Safety and Privacy
echo =========================================
choice /n /c:12 /m:"Choice: "
:: if %errorlevel% == 1 goto security
if %errorlevel% == 1 goto appearance
if %errorlevel% == 2 goto safetyandprivacy
:security
cls
for /f "delims=" %%a in ('type "C:\Users\%username%\AppData\Roaming\HackerTool\cpass.pow"') do (
    set "powpass=%%a"
)
echo =========================================
echo Security
echo =========================================
echo Custom Password : %powpass%
echo (1) Set custom password
echo (2) Turn off custom password
pause

:appearance
echo =========================================
echo Appearance
echo =========================================
echo (1) Set custom color
echo (R) Return
echo =========================================
choice /n /c:1R /m:"Choice: "
if %errorlevel% == 1 goto setcuscol
if %errorlevel% == 2 goto clsdash
exit

:setcuscol
cd C:\Users\%username%\AppData\Roaming\HackerTool
echo =========================================
echo Select custom color:
echo.
echo 0 = Black       8 = Gray
echo 1 = Blue        9 = Light Blue
echo 2 = Green       A = Light Green
echo 3 = Aqua        B = Light Aqua
echo 4 = Red         C = Light Red
echo 5 = Purple      D = Light Purple
echo 6 = Yellow      E = Light Yellow
echo 7 = White       F = Bright White
echo.
echo Note: Background first
echo For example: 0a (0 <--- Background  Text ---> a)
echo =========================================
set /p color= Color: 
color %color%
if %errorlevel% == 1 goto setcuscol
del C:\Users\%username%\AppData\Roaming\HackerTool\colors.txt
echo background=%color% >>colors.txt
cls
echo Custom Color set!
goto clsdash

:safetyandprivacy
cd C:\Users\%username%\AppData\Roaming\HackerTool
echo =========================================
echo Safety and Privacy
echo =========================================
echo (1) Turn on IP Displaying
echo (2) Turn off IP Displaying
echo (R) Return
echo =========================================
choice /n /c:12R /m:"Choice: "
if %errorlevel% == 1 goto ipturnon
if %errorlevel% == 2 goto ipturnoff
if %errorlevel% == 3 goto clsdash
exit


:ipturnon
del C:\Users\%username%\AppData\Roaming\HackerTool\ipdisplaying.txt
echo displayip=true >>ipdisplaying.txt
set "public_ip=!backip!"
goto safetyandprivacy

:ipturnoff
del C:\Users\%username%\AppData\Roaming\HackerTool\ipdisplaying.txt
echo displayip=false >>ipdisplaying.txt
set "public_ip=Hidden"
goto safetyandprivacy

:about
echo HackerTool %htv%
echo (c) Movement Studio 2024
echo.
echo =========================================
echo WMS_Dawidolowid
echo =========================================
echo (G) Github
echo (Y) YouTube
echo =========================================
echo Movement Studio
echo =========================================
echo (D) Discord
echo =========================================
echo (R) Return
echo =========================================
choice /n /c:"GYDR" /m:"Choice: "
if %errorlevel% == 1 goto githubdawidolowid
if %errorlevel% == 2 goto youtubedawidolowid
if %errorlevel% == 3 goto discordinter
if %errorlevel% == 4 goto clsdash

:githubdawidolowid
start https://github.com/wrt-dawidolowid
cls
goto about

:youtubedawidolowid
start https://www.youtube.com/channel/UCO5ArhZqNClUKCOoP28VhAA
cls
goto about

:discordinter
start https://discord.gg/r4T6pKyxS3
cls
goto about

:geo
echo Enter Geolocation IP!
echo Leave Blank to geolocate yourself
set ip=
set /p ip= ">>"
powershell -File "C:\Program Files\Movement Studio\HackerTool\HackerToolGeolocationSystem.ps1" %ip%
echo.
pause
cls
goto %dashboard%



:ping
echo Enter Ping IP!
set /p ipp= ">>"
if "%ipp%"=="" goto ping
ping %ipp%
echo.
pause
cls
goto %dashboard%

:check
set /p argupass=<%1
if %argupass%==%username%-%PROCESSOR_ARCHITECTURE%-%NUMBER_OF_PROCESSORS% goto argd
echo Incorrect ArguPass
pause
exit

:argd
echo Logging using ArguPass...
goto %dashboard%


:blacklist
echo You can't use HackerTool because your IP is blacklisted in HackerTool!
echo.
pause
exit



:ddos
echo Welcome in DDoS
echo Are you sure you want to ddos? If you want to close DDoSer, you will have to restart your computer
choice /n /c:YN /m:"(YES : Y , NO : N)"
if %errorlevel% == 1 goto ddosstart
if %errorlevel% == 2 goto clsdash
exit
:clsdash
cls
goto %dashboard%
:ddosstart
set /p ip= "Enter IP >>"
set /p repetitions= "Times >>"
cd "C:\Program Files\Interface Studio\Hacker Tool"
echo Starting ddosers...
for /l %%i in (1,1,%repetitions%) do (
    start ddos.exe
)
echo Starting ddosers complete!
pause
cls
goto %dashboard%






:errorddos
echo Requested ip is not giving any data!
echo.
pause
cls
goto dashboard

:devopt
echo          Developer Options
echo.
echo [1] Open HackerTool Command Prompt
choice /n /c:1
if %errorlevel% == 1 goto obsistcmd
exit

:obsistcmd
echo Welcome in HackerTool CMD
echo.
:cmd
set cmd=
set /p cmd= "HackerTool-Main >>"
if "%cmd%"=="" goto cmd
if %cmd% == warpversions goto warp
if %cmd% == mode goto modesel
if %mode% == exit goto %dashboard%
echo Command %cmd% does not exist
goto cmd
:warp
echo Welcome in HackerTool Warp Versions
echo Enter the number next to the version you want to warp to
echo Available versions:
echo 1. HackerTool 1.4
set /p ver=">>"
echo Are you sure you want to install HackerTool 1.4
echo Type "Yes" to install. Type "No" to return

:modesel
echo Select BETA or discontinued mode from HackerTool
:modeprom
set mode=
set /p mode= "Mode-Selector >>"
if %mode% == ddos goto ddos
if %mode% == options goto optionsnew
if %mode% == exit goto %dashboard%
goto modeprom
exit
:insupd
set "counter=1"
for /f "tokens=*" %%a in ('type "C:\Users\%username%\AppData\Local\Temp\UpdateInfo.inf"') do (
    if !counter! equ 3 (
        set "versionname=%%a"
        goto nextc
    )
    set /a "counter+=1"
)
:nextc
set "counter=1"
for /f "tokens=*" %%a in ('type "C:\Users\%username%\AppData\Local\Temp\UpdateInfo.inf"') do (
    if !counter! equ 6 (
        set "updateorpatch=%%a"
        goto next
    )
    set /a "counter+=1"
)
:next
echo.
echo =========================================
echo A new %updateorpatch% is available
echo =========================================
echo Your version : HackerTool %htv%
echo New version : %versionname%
echo =========================================
echo Do you want to install it?
echo =========================================
echo (Y) Yes
echo (N) No
echo =========================================
:choiceupdate
choice /n /c:"YND" /m:"Choice: "
if %errorlevel% == 1 goto installupdate
if %errorlevel% == 2 goto premcheck
if %errorlevel% == 3 goto details
exit

:details
echo =========================================
echo Version ID: %versionid%
echo =========================================
goto choiceupdate





:installupdate
color 07
echo Preparing for update...

set "counter=1"
for /f "tokens=*" %%a in ('type "C:\Users\%username%\AppData\Local\Temp\UpdateInfo.inf"') do (
    if !counter! equ 5 (
        set "updatemirror=%%a"
        goto down
    )
    set /a "counter+=1"
)

:down
echo Downloading update...
cd "C:\Program Files\Movement Studio\HackerTool"
del HackerTool.exe /s /q >nul 2>&1
del HackerTool.exe /s /q >nul 2>&1
certutil -split -urlcache -f "%updatemirror%" "C:\Users\%username%\AppData\Roaming\HackerToolFiles.zip" >nul
call "C:\Program Files\Movement Studio\HackerTool\HackerToolUpdater.exe" >nul 2>&1
if %errorlevel% == 1 goto errorupdate
cls
echo %versionname% successfully installed!
:8
pause >nul
goto 8

:errorupdate
echo There was a problem with HackerToolUpdater while tried to install %versionname%.
echo Reinstalling the program from installer may fix this problem.
goto 8

:disabled
echo HackerTool is Disabled by an Administrator!
pause
exit

:optionsnew
echo =========================================
echo Options - HackerTool Project (Discontinued)
echo =========================================
echo Processor Architecture : %PROCESSOR_ARCHITECTURE%
echo Number Of Processors : %NUMBER_OF_PROCESSORS%
echo =========================================
echo (1) Power Options
echo =========================================
choice /n /c:1 /m:"Choice: "
if %errorlevel% == 1 goto power
exit
:power
echo =========================================
echo Power Options
echo =========================================
echo (1) Shutdown
echo (2) Restart
echo =========================================
choice /n /c:12 /m:"Choice: "
if %errorlevel% == 1 goto shutdown
if %errorlevel% == 2 goto restart
exit

:shutdown
shutdown -s -t 0
exit

:restart
shutdown -r -t 0
exit

:welcome
set %1=none
echo Welcome in HackerTool
echo.
echo ===========================================================
echo HackerTool is advanced MultiTool with:
echo - Geolocation
echo - Ping
echo - Proxy Check
echo - PaySafeCard Generator
echo - Random Number Generator
echo - String Search
echo - Domain Converter
echo - API Connection
echo ============================================================
echo Press "R" to run HackerTool
echo Press "X" to exit
echo ============================================================
choice /n /c:RX /m:"Choice: "
if %errorlevel% == 1 goto start
if %errorlevel% == 2 exit
exit
