############################################################
## Python send_audio for audio Project  	              ##
## by Martin AUCHER & Kevin PEREZ, 04/2020                ##
##                                                        ##
## Code used for audio Project courses at ENSEIRB-MATMECA ##
############################################################

import tkinter as tk
from tkinter import ttk 
import tkinter.filedialog
import serial
import serial.tools.list_ports
import func
import os
import wave
import wget

#? variables definition ?#
SampleRate = 44100 #! sample/seconds !#
max_len = 60 #! Longeur max en secondes !#
tmp_file = "/tmp/aud2mp3.wav" #! Fichier WAV temporaire !#
demo_url = "http://nas.aucher.xyz/zeppelin.mp3"
filepath = ""

def browse_file(value_tk):
    filepath = tk.filedialog.askopenfilename(title = "Select A File")
    value_tk.set(filepath)

def load_file(url_or_file,audio_url,file_audio_path,speed,port):
    # print("----------------------")
    # print("url_or_file : "+str(url_or_file))
    # print("audio_url : "+str(audio_url))
    # print("file_audio_path : "+str(file_audio_path))
    # print("speed : "+str(speed))
    # print("port : "+str(port))

    ser = serial.Serial("/dev/"+str(port), int(speed), 8, 'N', 1)

    if(str(url_or_file)=="url"):
        url_file = "/tmp/yt.mp3"

        wget.download(str(audio_url), url_file)

        func.audio2wav(str(url_file),tmp_file,SampleRate,max_len)
        #os.remove(yt_file)
    else:
        func.audio2wav(str(file_audio_path),tmp_file,SampleRate,max_len)

    
    file_wav = wave.open(tmp_file, mode='rb')
    audio = func.file2mono(file_wav)
    file_wav.close()
    os.remove(tmp_file)
    audio = func.normalize(audio)

    num = []

    for i in range(0,len(audio)):
        a = audio[i].to_bytes(2, 'little', signed=True)
        num.append(a[0]);num.append(a[1])

    listofzeros = [0]*max_len*44100

    ser.write(listofzeros) # ? clear ram
    ser.write(num) # ! write data to ram
    quit()

ports = []
for x in serial.tools.list_ports.comports():
    ports.append(x.name)

window = tk.Tk()

width  = window.winfo_screenwidth()
height = window.winfo_screenheight()

window.title("MP3 Project, Serial Loading")
window.resizable(width=tk.FALSE, height=tk.FALSE)
window.geometry(f'{int(width/4)}x{int(height/3)}')

# definition de la premiere frame serial
serial_frame = tk.Frame(window, borderwidth=1, highlightthickness=1, width=100, height=100, bd= 0)#, highlightbackground="blue")
serial_frame.pack(fill=tk.X)

# definition de la seconde frame file
audio_frame = tk.Frame(window, borderwidth=1, highlightthickness=1, width=100, height=100, bd= 0)#, highlightbackground="red")
audio_frame.pack(fill=tk.X)

# definition de la troixieme frame buttons
buttons_frame = tk.Frame(window, borderwidth=1, highlightthickness=1, width=100, height=100, bd= 0)#, highlightbackground="red")
buttons_frame.pack(fill=tk.X)

# definition du message serial
serial_message = tk.Label(serial_frame, text="Serial parameters")
serial_message.grid(row=0, column=0, columnspan=2)

# definition du message audio
audio_message = tk.Label(audio_frame, text="File to load")
audio_message.grid(row=0, column=0, columnspan=3)

padv = 200

# liste deroulante des ports series
ports_message = tk.Label(serial_frame, text="Select serial Port")
ports_message.grid(row=1, column=0, padx=padv)

ports_list = ttk.Combobox(serial_frame, values=ports)
ports_list.current(len(ports)-1)
ports_list.grid(row=2, column=0, padx=padv)

# liste deroulante des speed series
speed_message = tk.Label(serial_frame, text="Select Port baudrate")
speed_message.grid(row=1, column=1, padx=padv)

speeds = ["9600","19200","38400","57600","115200","921600"]

speed_list = ttk.Combobox(serial_frame, values=speeds)
speed_list.current(len(speeds)-1)
speed_list.grid(row=2, column=1, padx=padv)

padv = 48

# Choix d'un fichier audio

url_or_file = tk.StringVar()
url_or_file.set("file")

tk.Radiobutton(audio_frame, variable=url_or_file, text="Select file to write", value="file", indicator = 0, fg="black").grid(row=1, column=0, padx=padv)
tk.Radiobutton(audio_frame, variable=url_or_file, text="Select Youtube URL", value="url", indicator = 0, fg="black").grid(row=1, column=2, padx=padv)

txt_var=tk.StringVar()
file_audio_path=tk.Entry(audio_frame, textvariable=txt_var, state="readonly", fg="black",width=40)
txt_var.set("Choose path ..")
file_audio_path.grid(row=2, column=0, padx=padv)

tk.Button(audio_frame, command=lambda:browse_file(txt_var) , text="Browse").grid(row=2, column=1, padx=padv)

# Choix d'une url audio

audio_url=tk.StringVar()
tk.Entry(audio_frame, textvariable=audio_url, fg="black",width=40).grid(row=2, column=2, padx=padv)
audio_url.set(demo_url)

# Creation des boutons de chargement et exit

load_button = tk.Button(buttons_frame, width=55,height=10, text="Load", command=lambda:load_file(url_or_file.get(),audio_url.get(),file_audio_path.get(),speed_list.get(),ports_list.get()))
load_button.grid(row=0, column=0)
tk.Button(buttons_frame, width=55,height=10, text="Quit", command=window.quit).grid(row=0, column=1)

window.mainloop()