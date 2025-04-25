@echo off
REM Set working directory
cd /d "C:\Users\D'Arcy\Dropbox\Publishing\App building\hmong\www-iphone"

REM Echo current step
echo --- Adding all files to Git ---
git add .

REM Create a timestamp
for /f %%i in ('powershell -Command "Get-Date -Format yyyy-MM-dd_HH-mm-ss"') do set timestamp=%%i

REM Commit with timestamp
git commit -m "Auto update %timestamp%"

REM Push to master
git push -u origin master

REM Echo deploy step
echo --- Deploying to Netlify ---
netlify deploy --dir="C:\Users\D'Arcy\Dropbox\Publishing\App building\hmong\www-iphone" --prod

REM Done
echo --- Deployment complete ---
pause
