from pydub import AudioSegment
import time

filename = "niksa.mp3"

# Target max len
max_len = 60 #! seconds !#

loop = 0

start_time = time.time()

song = AudioSegment.from_file(filename, filename.split(".")[-1])

song_len = song.duration_seconds

if(song_len < max_len):
    if(loop):
        song = song * int((max_len/song_len))
    else:
        song = song + AudioSegment.silent(duration=1000*(max_len-song_len))
else:
    song = song[:1000*max_len]


song.export("coucou.wav", format="wav")

end_time = time.time()
spent = end_time-start_time

print("Time spent : ", end="")
print(f'{spent:.1f}')

pass