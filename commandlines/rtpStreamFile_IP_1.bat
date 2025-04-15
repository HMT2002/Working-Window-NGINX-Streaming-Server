@REM RTP (Real-time Transport Protocol) primarily uses UDP (User Datagram Protocol) for real-time media transmission, as UDP is better suited for low-latency, time-sensitive applications where some packet loss is acceptable. 
@REM comment note
chcp 65001
set filename=%~1
:: Extract the filename without the extension
for %%F in ("%filename%") do set basename=%%~nF

@REM ffmpeg -re -stream_loop -1 -i "%1" ^
@REM  -map 0:v -vcodec copy -payload_type 96 -f rtp rtp://127.0.0.1:3411 ^
@REM  -map 0:a -acodec libopus -payload_type 97 -f rtp rtp://127.0.0.1:3413 ^
@REM  -sdp_file stream.sdp

@REM ffmpeg -re -stream_loop -1 -i "%1" ^
@REM  -map 0:v -vcodec copy -payload_type 96 -f rtp rtp://localhost:3411 ^
@REM  -map 0:a ^
@REM  -acodec copy ^
@REM  -payload_type 97 -f rtp rtp://localhost:3413 ^
@REM  -sdp_file stream.sdp


ffmpeg -re -stream_loop -1 -i "%filename%" ^
 -map 0:v ^
 -c:v libx264 ^
 -f rtp "rtp://127.0.0.1:1936" ^
 -map 0:a ^
 -c:a aac ^
 -f rtp "rtp://127.0.0.1:1938" ^
 -sdp_file stream.sdp

@REM ffmpeg -re -stream_loop -1 -i "%1" ^
@REM  -map 0:v ^
@REM  -vcodec copy ^
@REM  -payload_type 96 ^
@REM  -f rtp rtp://localhost:3411 ^
@REM  -sdp_file stream.sdp

@REM ffplay -protocol_whitelist file,udp,rtp -i stream.sdp
@REM -acodec libopus ^


@REM mpv stream.sdp

@REM ffprobe -i "stream.sdp" -show_entries packet=size,pts_time,flags,duration_time > packets.log -protocol_whitelist file,udp,rtp
@REM 127.0.0.1 vlc can only play with 127.0.0.1, not localhost