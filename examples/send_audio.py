import time
import wave
import tkinter as tk
from tkinter import filedialog
import os
import serial
import string
import math
import func
import wget

args = func.set_parser()

ser = serial.Serial(args.p, args.b, 8, 'N', 1, timeout=1)

root = tk.Tk()
root.withdraw()

#? variables definition ?#
SampleRate = 44100 #! sample/seconds !#
max_len = 6 #! Longeur max en secondes !#
tmp_file = "/tmp/aud2mp3.wav" #! Fichier WAV temporaire !#
demo_url = "http://nas.aucher.xyz/zeppelin.mp3"
in_file = "/tmp/zepplin.mp3"


# if(local):
#     in_file = filedialog.askopenfilename()
# elif(spotify):
#     pass
# else if(demo):
#     wget.download(demo_url, "/tmp/zepplin.mp3")

wget.download(demo_url, in_file)

print("\nSending file : \"" + in_file + "\" at " + str(args.b) + " bauds on \"" + str(args.p) + "\"")

# chemin du fichier converti

start_time = time.time()

func.audio2wav(in_file,tmp_file,SampleRate,max_len)

# objet Wave_read du fichier
file_wav = wave.open(tmp_file, mode='rb')

# Stereo to mono
audio = func.file2mono(file_wav)
file_wav.close()
os.remove(tmp_file)

# Normalization
audio = func.normalize(audio)

num = []

for i in range(0,len(audio)):
    a = audio[i].to_bytes(2, 'little', signed=True)
    num.append(a[0]);num.append(a[1])

""" fonctionne absolument bien """
listofzeros = [0]*2**18

print("Clearing RAM")
ser.write(listofzeros) # ? clear ram

print("Writing RAM")
ser.write(num) # ! write data to ram

print("Done")

spent = time.time()-start_time
print("Time spent : ", end="")
print(f'{spent:.1f}')