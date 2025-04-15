chcp 65001
set filename=%~1
:: Extract the filename without the extension
for %%F in ("%filename%") do set basename=%%~nF


ffmpeg -re -stream_loop -1 -i "%~1" -c:v libx264 -loop -1 -c:a aac -f flv "rtmp://%~2/live/%basename%"

::ffmpeg -re -stream_loop -1 -i "%~1" -c:v copy -c:a aac -f flv "rtmp://localhost:1936/live/%~1"