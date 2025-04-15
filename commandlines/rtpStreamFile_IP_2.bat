chcp 65001
ffmpeg -stream_loop -1 -y -re -i "%~1" ^
 -c:a aac ^
 -c:v libx264 ^
 -f rtp_mpegts "rtp://%~2/%~1"
::ffmpeg -stream_loop -1 -y -re -i "%~1.mp4" -loop -1 -an -c:v copy -f rtp -sdp_file video.sdp "rtp://%2/%~1"
::mpv rtp://localhost:3415
::Uses -strict -2 to allow experimental codecs/features