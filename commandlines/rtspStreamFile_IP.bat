chcp 65001
ffmpeg -re -stream_loop -1 -i "%1" ^
 -c:v copy ^
 -c:a copy ^
 -loop -1 ^
 -rtsp_transport udp ^
 -f rtsp  "rtsp://%~2"