chcp 65001
@echo off 
cls 
 
if not exist %1 ( 
mkdir %1
echo Folder created.
 ) else ( 
echo Folder already exists! 
) 
ffmpeg -re -i "%1.mkv" -map 0 -map 0 -c:a aac -c:v libx264 -b:v:0 800k -b:v:1 300k -s:v:1 320x170 -profile:v:1 baseline -profile:v:0 main -bf 1 -keyint_min 120 -g 120 -sc_threshold 0 -b_strategy 0 -ar:a:1 22050 -use_timeline 1 -single_file 1 -use_template 1 -adaptation_sets "id=0,streams=v id=1,streams=a" -f dash %1/index.mpd