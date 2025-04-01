chcp 65001
ffmpeg -re -stream_loop -1 -i "%1" -vcodec copy -loop -1 -c:a copy -f rtsp -rtsp_transport udp "rtsp://localhost:4311/live.sdp"