%clc;
%clear;
%%
%Inicialización y convolución
[y1,fs1] = audioread('Palabra hablada 2 (ingles).WAV');% Señal anecoica
y1p=y1(1:48000);
[y2,fs] = audioread('D-MRIR-PSCJ-FSO1M3-esw.wav');% Respuesta impulsiva medida
y3=conv(y1,y2); % Convoluciona la señal anecoica con la respuesta impulsiva
audiowrite('señaldeexcitacion-mono-1m2.wav',y3,fs);

% PSD de la señal CONVOLUCIONADA
figure(1)
nfft1 = 2^nextpow2(length(y3)); %Devuelve la menor potencia de dos que sea mayor o igual a length(y3r)
Pxx1 = abs(fft(y3,nfft1)).^2/length(y3)/fs;
Hpsd1=dspdata.psd(Pxx1(1:length(Pxx1)/2),'fs',fs);
plot(Hpsd1)
xlabel('Frecuencia [kHz]');
ylabel('Potencia/Frecuencia [dB/Hz]');
title('CONVOLUCIONADA')
ylim([-170 -10]);
xlim([0.02 10]);
grid on
%%
% PSD de la señal ORIGINAL
figure(2)
nfft1=2^nextpow2(length(y1));
Pxx1=abs(fft(y1p,nfft1)).^2/length(y1p)/fs;
Hpsd1=dspdata.psd(Pxx1(1:length(Pxx1)/2),'fs',fs);
plot(Hpsd1)
xlabel('Frecuencia [kHz]');
ylabel('Potencia/Frecuencia [dB/Hz]');
title('ORIGINAL')
ylim([-150 50]);
xlim([0.02 10]);
grid on
%%
% FFT de ambas señales ORIGINAL Y CONVOLUCIONADA
figure(3)
NFFT1=2^nextpow2(L1);
% fft señal original
Y1 = fft(y1p,NFFT1)/L1;% (anecoica)
LIN1=linspace(0,1,NFFT1/2+1);
f1 = fs1/2*LIN1;
L3=length(y3);
NFFT3=2^nextpow2(L3); %fft señal convolucionada
Y3 = fft(y3,NFFT3)/L3;% (auralizada)
LIN3=linspace(0,1,NFFT3/2+1);
f3 = fs/2*LIN3;
plot(f1,2*abs(Y1(1:NFFT1/2+1)),'b');
hold on
plot(f3,2*abs(Y3(1:NFFT3/2+1)),'r');% gráficos
hold off
axis([0 1000 0 0.1])
legend('Original','Convolucionada')
title('Espectro de ORIGINAL vs CONVOLUCIONADA ')
xlabel('Frequencia (Hz)');
ylabel('|Y(f)|');
grid on