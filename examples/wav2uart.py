import wave
import struct

#? variables definition ?#

# Target sample rate
SampleRate = 44100 #! sample/seconds !#

# Target max len
MaxLen = 60 #! seconds !#

# chemin du fichier a convertir
filename = '/home/user/cours/PR209_MP3/examples/coucou.wav'

# objet Wave_read du fichier
file_wav = wave.open(filename, mode='rb')

file_uart = open('out.uart', 'wb')

# debug
print(file_wav.getparams())

# récupération des caracteristiques du fichier
samp_width = file_wav.getsampwidth()
channels   = file_wav.getnchannels()
Fs         = file_wav.getframerate()
l          = file_wav.getnframes()
y          = file_wav.readframes(l*samp_width*channels)

left  = []
right = []

for i in range(0, l*samp_width*channels, 4):
  left.append(int.from_bytes(y[i:i+2], byteorder='little', signed=True))
  right.append(int.from_bytes(y[i+2:i+4], byteorder='little', signed=True))

# Stereo to mono
audio = [int(left[i]+right[i])/2 for i in range(0,l)]

# Normalizing
mini = min(audio)
maxi = max(audio)
if(maxi > mini): #max plus grand
    audio = [int((x*1024)/maxi) for x in audio]  
else: #%min plus grand
    audio = [int((x*1024)/mini) for x in audio]

for i in range(0, l):
    file_uart.write(audio[i].to_bytes(2, 'little', signed=True))


file_uart.close()
file_wav.close()