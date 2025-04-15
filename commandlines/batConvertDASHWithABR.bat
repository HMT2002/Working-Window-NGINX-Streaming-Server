chcp 65001
set filename=%~1
:: Extract the filename without the extension
for %%F in ("%filename%") do set basename=%%~nF

chcp 65001
@echo off 
cls 
 
if not exist %basename% ( 
mkdir %basename%
echo Folder created.
 ) else ( 
echo Folder already exists! 
) 


.\ffmpeg -i %filename% ^
 -c:v libx264 ^
 -c:a aac -b:a 128k ^
 -bf 1 -b_strategy 0 -sc_threshold 0 -pix_fmt yuv420p ^
 -map 0:v:0 -map 0:a:0 -map 0:v:0 -map 0:a:0 -map 0:v:0 -map 0:a:0 ^
 -b:v:0 300k  -s:v:0 720x480 -profile:v:0 baseline ^
 -b:v:1 700k  -s:v:1 1080x720 -profile:v:1 main ^
 -b:v:2 1300k -s:v:2 1920x1080 -profile:v:2 high ^
 -b:v:3 2500k ^
 -f mpegts - | ^
.\ffmpeg -f mpegts -i - ^
 -map 0 ^
 -use_timeline 1 -use_template 1 -adaptation_sets "id=0,streams=v id=1,streams=a" ^
 -f dash "%basename%/init.mpd"
 
::To chain FFmpeg commands where the output of one command serves as the input to the next command without creating intermediate files, you can use FFmpeg's pipe functionality. This is done with the special "-" filename, which represents stdin/stdout.

REM -i videos/ZLDY4rk.mp4 -map 0 -preset faster -c:v libx265 -c:a aac -b:v:0 300k -s:v:0 720x480 -b:v:1 700k -s:v:1 1080x720 -b:v:2 1300k -s:v:2 1920x1080 -b:v:3 2500k -bf 1 -keyint_min 120 -g 120 -sc_threshold 0 -b_strategy 0 -ar:a:0 44100 -use_timeline 1 -single_file 0 -use_template 1 -seg_duration 10 -init_seg_name init_$RepresentationID$.m4s -media_seg_name chunk_$RepresentationID$_$Number%05d$.m4s -f dash videos/ZLDY4rkDash/init.mpd 

::ffmpeg -i videos/G8jWSF0.mp4 -c:v libx264 -c:a aac -b:a 44100 -bf 1 -b_strategy 0 -sc_threshold 0 -pix_fmt yuv420p -map 0:v:0 -map 0:a:0 -map 0:v:0 -map 0:a:0 -map 0:v:0 -map 0:a:0 -b:v:0 300k  -s:v:0 720x480 -profile:v:0 baseline -b:v:1 700k  -s:v:1 1080x720 -profile:v:1 main -b:v:2 1300k -s:v:2 1920x1080 -profile:v:2 high -b:v:3 2500k  -f mpegts videos/G8jWSF0.mp4_temp


::ffmpeg -i videos/0baClHv.mp4_temp -map 0 -use_timeline 1 -adaptation_sets "id=0,streams=v id=1,streams=a" -single_file 0 -use_template 1 -seg_duration 10 -adaptation_sets "id=0,streams=v id=1,streams=a" -init_seg_name init_$RepresentationID$.m4s -media_seg_name chunk_$RepresentationID$_$Number%05d$.m4s -f dash videos/0baClHvDash/init.mpd