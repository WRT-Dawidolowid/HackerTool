Write-Host "Extracting HackerTool files..." -ForegroundColor Green
Expand-Archive -Path "C:\Users\$env:USERNAME\AppData\Roaming\HackerToolFiles.zip" -DestinationPath "C:\Program Files\Movement Studio\HackerTool" -Force
Write-Host "Extracted successfully!" -ForegroundColor Green
Write-Host "Cleaning up..." -ForegroundColor Red