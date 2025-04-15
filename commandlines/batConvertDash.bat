chcp 65001
@echo off 
cls 
 
if not exist "%~1Dash" ( 
mkdir "%~1Dash"
echo Folder created.
 ) else ( 
echo Folder already exists! 
)
REM ffmpeg -re -i "%1.mp4" -map 0 -map 0 ^
REM -c:a copy ^
REM -c:v copy ^
REM -b:v:0 1000k -b:v:1 300k -s:v:1 320x170 ^
REM -profile:v:1 baseline -profile:v:0 main ^
REM -bf 1 -keyint_min 120 -g 120 -sc_threshold 0 -b_strategy 0 -ar:a:1 22050 ^
REM -use_timeline 1 -single_file 0 -use_template 1 -seg_duration 5 -adaptation_sets "id=0,streams=v id=1,streams=a" ^
REM -f dash "%1/init.mpd"

ffmpeg -re -i "%~1" ^
 -preset veryslow ^
 -g 60 ^
 -sc_threshold 0 ^
 -b:v:0 5000k ^
 -maxrate 5000k ^
 -bufsize 10000k ^
 -f dash "%~1Dash/init.mpd" ^
 -hls_playlist 0 ^
 -use_timeline 1 ^
 -use_template 1 ^
 -min_seg_duration 10000000 ^
 -window_size 5
@REM  -preset veryfast ^
@REM  -map 0:v:0 -b:v:0 5000k -s 1920x1080 -f dash -dash_segment_filename "1080p/segment_%05d.m4s" -init_seg_name "1080p/init.mp4" -mpd_name "1080p/manifest.mpd" ^
@REM  -map 0:v:0 -b:v:1 3000k -s 1280x720 -f dash -dash_segment_filename "720p/segment_%05d.m4s" -init_seg_name "720p/init.mp4" -mpd_name "720p/manifest.mpd" ^
@REM  -map 0:v:0 -b:v:2 1500k -s 854x480 -f dash -dash_segment_filename "480p/segment_%05d.m4s" -init_seg_name "480p/init.mp4" -mpd_name "480p/manifest.mpd" ^ 