clc;
clear;
%%
%Inicializaci�n y convoluci�n
[y1,fs1] = audioread('Palabra hablada 2 (ingles).WAV');% Se�al anecoica
y1=y1(1:48000).*0.05;
[y2,fs] = audioread('BRIR-SUM NORES-esw-p2.wav');% Respuesta impulsiva medida
y2R = y2(1:220500 , 1);
y2L = y2(1:220500 , 2);
y3R=conv(y1,y2R);
y3L=conv(y1,y2L);
audiowrite('se�alexcitacion-R-esw-p2.wav',y3R,fs);
audiowrite('se�alexcitacion-L-esw-p2.wav',y3L,fs);

%%
% PSD de la se�al CONVOLUCIONADA DERECHA
figure(1)
nfft1R = 2^nextpow2(length(y3R)); %Devuelve la menor potencia de dos que sea mayor o igual a length(y3r)
Pxx1R=abs(fft(y3R,nfft1R)).^2/length(y3R)/fs;
Hpsd1R=dspdata.psd(Pxx1R(1:length(Pxx1R)/2),'fs',fs);
plot(Hpsd1R)
xlabel('Frecuencia [kHz]');
ylabel('Potencia/Frecuencia [dB/Hz]');
title('CONVOLUCIONADA DERECHA')
ylim([-180 -30]);
xlim([0.02 10]);
grid on
%%
% PSD de la se�al CONVOLUCIONADA IZQUIERDA
figure(2)
nfft1L = 2^nextpow2(length(y3L));
Pxx1L = abs(fft(y3L,nfft1L)).^2/length(y3L)/fs;
Hpsd1L=dspdata.psd(Pxx1L(1:length(Pxx1L)/2),'fs',fs);
plot(Hpsd1L)
xlabel('Frecuencia [kHz]');
ylabel('Potencia/Frecuencia [dB/Hz]');
title('CONVOLUCIONADA IZQUIERDA')
ylim([-200 -40]);
xlim([0.02 10]);
grid on
%%
% PSD de la se�al ORIGINAL
figure(3)
nfft1=2^nextpow2(length(y1));
Pxx1=abs(fft(y1,nfft1)).^2/length(y1)/fs;
Hpsd1=dspdata.psd(Pxx1(1:length(Pxx1)/2),'fs',fs);
plot(Hpsd1)
xlabel('Frecuencia [kHz]');
ylabel('Potencia/Frecuencia [dB/Hz]');
title('ORIGINAL')
ylim([-200 -60]);
xlim([0.02 10]);

grid on
%%
% FFT de ambas se�ales ORIGINAL Y DERECHA
figure(4)
L1=length(y1);
NFFT1 = 2^nextpow2(L1);
LIN1=linspace(0,1,NFFT1/2+1);
f1 = fs/2*LIN1;
L3R=length(y3R);
NFFT3R = 2^nextpow2(L3R);
LIN3R=linspace(0,1,NFFT3R/2+1);
f3R = fs/2*LIN3R;
plot(f1,2*abs(y1(1:NFFT1/2+1)),'b');
hold on
plot(f3R,2*abs(y3R(1:NFFT3R/2+1)),'r');
hold off
axis([0 1000 0 0.1])
legend('Original','Convolucionada')
title('Espectro de ORIGINAL vs CONVOLUCIONADA DERECHA')
xlabel('Frequencia (Hz)');
ylabel('|Y(f)|');
grid on
%%
% FFT de ambas se�ales ORIGINAL e IZQUIERDA
figure(5)
L3L=length(y3L);
NFFT3L = 2^nextpow2(L3L);
Y3L = fft(0.2*y3L,NFFT3L)/L3L;
LIN3L=linspace(0,1,NFFT3L/2+1);
f3L = fs/2*LIN3L;
plot(f1,2*abs(y1(1:NFFT1/2+1)),'b');
hold on
plot(f3L,2*abs(Y3L(1:NFFT3L/2+1)),'r');
hold off
axis([0 1000 0 0.1])
legend('Original','Convolucionada')
title('Espectro de ORIGINAL vs CONVOLUCIONADA IZQUIERDA')
xlabel('Frequencia (Hz)');
ylabel('|Y(f)|');
grid on
