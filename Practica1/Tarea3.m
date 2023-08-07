f0=1/0.08;
t = 0:1/Fs:Dur;
salida=[];

for k = 1:size(armonico,2)
    for i=1:size(t,2)
        Ckx(i) = CoefA(k)*cos(2*pi*armonico(k)*f0*i) + CoefB(k)*sin(2*pi*armonico(k)*f0*i);
    end
    salida=[salida,Ckx];
end

salida = .5*salida/max(salida);
audiowrite("salida.wav",salida,Fs);
spectrogram(salida,"yaxis");