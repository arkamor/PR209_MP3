% Init

close all; clear all; clc;

% Start

[file,path] = uigetfile({'*.mp3;*.wav;*.ogg;*.flac;*.au;*.aiff;*.aifc;*.m4a;*.mp4','AUDIO Files (*.mp3,*.wav,*.ogg,*.flac,*.au,*.aiff,*.aifc,*.m4a,*.mp4)';'*.*','All Files (*.*)'},'Select a File');

filename = strcat(path,file);
[y,Fs] = audioread(filename);

l = length(y);

if size(y,2) == 2 %Si c'est du stereo
    % On le passe en mono
    Z = zeros(1,2^18);
    for i = 1:l-1
        Z(i) = (y(i,1)+y(i,2))/2;
    end
    y=Z;
    clear Z;
end

mini = abs(min(y));
maxi = max(y);

% Normalisation du vecteur

if(mini < maxi) %max plus grand
    y=(y*1024)/maxi;
else %min plus grand
    y=(y*1024)/mini;
end

% Extraction du nom du fichier

[filepath,name,ext] = fileparts(filename);

% Ecriture
answer = questdlg(strcat("Écriture du fichier de sortie sur : ",path),'Changer le chemin d ecriture ?','Oui','Non','Non');

if isequal(answer ,'Non')
        path = strcat(uigetdir(path),'/');
end

fileID = fopen(strcat(path,name,'.uart'),'w');

fwrite(fileID,y,'int16');

% Fermeture du fichier

fclose(fileID);

msgbox(strcat('Fichier "',path,name,'.uart"',' créé avec succès'),'Ecriture réussie','help')


