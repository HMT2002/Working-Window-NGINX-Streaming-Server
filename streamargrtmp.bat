chcp 65001
ffmpeg -re -stream_loop -1 -i "%~1" -vcodec libx264 -loop -1 -c:a aac -f flv "rtmp://localhost:1936/live/%~1"

::ffmpeg -re -stream_loop -1 -i "%~1" -c:v copy -c:a aac -f flv "rtmp://localhost:1936/live/%~1"