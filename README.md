# Projet lecteur audio

Projet de conception de lecteur audio en cours ENSEIRB-MATEMCA
Co-réalisé avec Kevin Perez [@MrKp57](https://github.com/mrkp57)

<p align="center">
  <img width="550" height="500" src="https://raw.githubusercontent.com/arkamor/PR209_MP3/master/Carte.JPG?token=AEKIRHA2O2JTXBPCYJOTEX26Y2AR2">
</p>

## Utilisation

 - Les afficheurs 7 segments se divise en 2 groupes de 4 afficheurs.
-  Les 4 afficheurs de droite affichent l’état actuel du lecteur : 
	 - <pre> ---- En pause </pre>
	 - <pre> ---] En lecture</pre>
	 - <pre> [--- En lecture en sens inverse</pre>
	 - <pre> [--] Stop </pre>
- Le premier afficheur à gauche du point est le volume.
- Les trois afficheurs directement à droite du point représentent le nombre de dixième de secondes écoulés depuis le debut de la lecture de la mémoire.
- Lorsque l'extrait audio sera terminé, il recommencera au début.

## Chargement 

- Le chargement s'effectue par liaison série.
- Les données doivent être envoyés brutes, sans compression ni codage particulier.
- Les échantillons audio doivent être envoyée dans l'ordre de la lecture au format 16 bits, l'octet de poids faible doit être envoyé en 1er suivi de l'octet de poids fort avant de passer à l'échantillon suivant.

Configuration de la liaison série est la suivante : 
```
921600 / 8-N-1
```

Il est possible d'utiliser un ordinateur pour charger l'extrait audio sur la carte.
Pour les ordinateurs sous windwos : préférer utiliser le script de chargement Matlab [ici](https://github.com/arkamor/PR209_MP3/blob/master/Load_sound/Generation_musique.m).

Pour une machine sous linux, préférer notre script de chargement Python :

 1. Installer les dépendances
```bash
foo@bar:~$ pip PR209_MP3/Load_sound/requirements.txt
```
2. Lancer le script en root (pour la liaison série)
```bash
foo@bar:~$ sudo python PR209_MP3/Load_sound/send_audio_gui.py #Avec GUI
```
```bash
foo@bar:~$ sudo python PR209_MP3/Load_sound/send_audio.py --help #Avec CLI
```

```bash
usage: send_audio.py [-h] [-v | -q] [-b B] [-p P]

The purpose of this program is to convert and then,
send audio files to Nexys 4 board loaded with MP3_Project.

optional arguments:
  -h, --help       show this help message and exit
  -v, --verbosity  Increase output verbosity (max 2)
  -q, --quiet      No output
  -b B             Change Baudrate,   default : 921600
  -p P             Change seial Port, default : /dev/ttyUSB1

Program written by Martin AUCHER and Kevin PEREZ
for ENSEIRB-MATMECA Numerical conception courses.
https://github.com/arkamor/PR209_MP3
```
