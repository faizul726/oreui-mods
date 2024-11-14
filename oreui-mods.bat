@echo off
setlocal

cd "%~dp0"
if not exist oreui-mods_data mkdir oreui-mods_data
pushd oreui-mods_data

echo OreUI Mods // Made possible thanks to @Stivusik
echo.

for /f "tokens=*" %%i in ('powershell -NoProfile -command "Get-AppxPackage -Name Microsoft.MinecraftUWP | Select-Object -ExpandProperty InstallLocation"') do set "minecraftlocation=%%i"
set "oreui=%minecraftlocation%\data\gui\dist\hbui\index-890d0.js"

goto skip_khan
if exist "index-890d0.js.bak" (
    rename "index-890d0.js.bak" "index-890d0.js"
    "%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /delete "%oreui%"
    "%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /move "%cd%\index-890d0.js" "%oreui:~0,-15%"
    exit
)
:skip_khan


if not exist "%oreui%" (
    echo "%oreui%" not found.
    echo.
    echo Press any key to exit
    pause > NUL
    exit
)

copy "%oreui%" index-890d0.js.bak
powershell -NoProfile -Command "$oreui = Get-Content -Path 'index-890d0.js.bak'; $oreui = $oreui -replace 'e\&\&a\.push\(\{label:"\.debugTabLabel"', 'a.push({label:".debugTabLabel"' -replace '\(u\|\|t\)&&a\.push\(_y\(\{label:i\("\.gameModeAdventureLabel"\)', '(true)&&a.push(_y({label:i(".gameModeAdventureLabel")'; $oreui | Set-Content -Path 'index-890d0.js'"

"%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /delete "%oreui%"
"%ProgramFiles(x86)%\IObit\IObit Unlocker\IObitUnlocker" /advanced /move "%cd%\index-890d0.js" "%oreui:~0,-15%"
