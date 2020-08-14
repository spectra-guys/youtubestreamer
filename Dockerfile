FROM jrottenberg/ffmpeg:3.4-alpine

# Run as a separate user
RUN adduser -D streamer
USER streamer

# Stream the bg.png to the channel given by the stream key. Based on https://discuss.dev.twitch.tv/t/guide-how-to-stream-a-test-image-for-extension-testing/16646
ENTRYPOINT []
CMD ffmpeg -stream_loop -1 -i "video.mov" -deinterlace \
    -vcodec libx264 -pix_fmt yuv420p -preset medium -r 30 -g $((30 * 2)) -b:v 2500K \
    -acodec libmp3lame -ar 44100 -threads 6 -qscale 3 -b:a 712000 -bufsize 512k \
    -f flv "rtmp://a.rtmp.youtube.com/live2/1qd7-8d7d-peda-62xc-egmh"