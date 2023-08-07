%Audio import

[a,fs]=audioread("SunshineSquare.wav");
d=length(a)/fs;
a_m=a(:,1).';

%Waveform plot
t=linspace(0,d,length(a_m));

figure()
spectrogram(a,"yaxis")


figure();
plot(t,a_m);
title("Audio Waveform");
xlabel("time [s]");
ylabel("Amplitude");
grid on;


%Frecuencia
A_m=fftshift(fft(a_m));
f=linspace(-fs/2,fs/2,length(A_m));
mag_A=abs(A_m);
figure();
plot(f,mag_A/max(mag_A));
title("Audio Frecuency Spectrum");
xlabel("Frecuency [Hz]");
ylabel("Amplitude");

ax=gca;
ax.XAxis.Exponent=3;

%Filtros Ideales
lpf=1.*(abs(f)<=500);
figure();
plot(f,lpf,"r");
title("Low Pass Filter");
xlabel("Frecuency [Hz]");
ylabel("Amplitude");
ax=gca;
ax.XAxis.Exponent=3;


%Filtros y Audio
figure();
plot(f,mag_A/max(mag_A));
hold on;
plot(f,lpf,"r");
legend("Audio","Filter");
title("Low Pass Filter");
xlabel("Frecuency [Hz]");
ylabel("Amplitude");
ax=gca;
ax.XAxis.Exponent=3;


%Filtrado
A_lpf=A_m.*lpf;  %Filtering
figure();
plot(f,abs(A_lpf)/max(abs(A_lpf)));
hold on;
plot(f,lpf,"r");
legend("Filtered Audio","Filter");
title("Low Pass Filter");
xlabel("Frecuency [Hz]");
ylabel("Amplitude");
ax=gca;
ax.XAxis.Exponent=3;

%Transformada Inversa
a_lpf=ifft(fftshift(A_lpf));
a_lpf=real(a_lpf);

%%Play Audios
%sound(a_lpf,fs);
%pause(d+1);
%sound(a_m,fs);

figure();
audiowrite("filtrado.wav",a_lpf,fs);
spectrogram(a_lpf,"yaxis")
