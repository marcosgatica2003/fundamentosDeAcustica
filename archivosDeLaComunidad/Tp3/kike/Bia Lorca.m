clc;
clear;
%%
%Inicialización y convolución
[y1 fs1] = wavread('Palabra hablada 2 (ingles).wav');% Señal anecoica
y1=y1(1:48000).*0.05;
[y2 fs] = wavread('BRIR-SUM NORES-esw-p1.wav');% Respuesta impulsiva medida
y2R = y2(1:220500 , 1);
y2L = y2(1:220500 , 2);
y3R=conv(y1,y2R);
y3L=conv(y1,y2L);
wavwrite(y3R, fs, 'señaldeexcitacion-R-esw-p1.wav');
wavwrite(y3L, fs, 'señaldeexcitacion-L-esw-p1.wav');
%%
% PSD de la señal CONVOLUCIONADA DERECHA
figure(1)
nfft1R = 2^nextpow2(length(y3R)); %Devuelve la menor potencia de dos que sea mayor o igual a length(y3r)
Pxx1R=abs(fft(y3R,nfft1R)).^2/length(y3R)/fs;
Hpsd1R=dspdata.psd(Pxx1R(1:length(Pxx1R)/2),'fs',fs);
plot(Hpsd1R)
xlabel('Frecuencia [kHz]');
ylabel('Potencia/Frecuencia [dB/Hz]');
title('CONVOLUCIONADA DERECHA')
ylim([-160 -20]);
xlim([0.02 10]);
grid on
%%
% PSD de la señal CONVOLUCIONADA IZQUIERDA
figure(2)
nfft1L = 2^nextpow2(length(y3L));
Pxx1L = abs(fft(y3L,nfft1L)).^2/length(y3L)/fs;
Hpsd1L=dspdata.psd(Pxx1L(1:length(Pxx1L)/2),'fs',fs);
plot(Hpsd1L)
xlabel('Frecuencia [kHz]');
ylabel('Potencia/Frecuencia [dB/Hz]');
title('CONVOLUCIONADA IZQUIERDA')
ylim([-160 -20]);
xlim([0.02 10]);
grid on
%%
% PSD de la señal ORIGINAL
figure(3)
nfft1=2^nextpow2(length(y1));
Pxx1=abs(fft(y1,nfft1)).^2/length(y1)/fs;
Hpsd1=dspdata.psd(Pxx1(1:length(Pxx1)/2),'fs',fs);
plot(Hpsd1)
xlabel('Frecuencia [kHz]');
ylabel('Potencia/Frecuencia [dB/Hz]');
title('ORIGINAL')
ylim([-160 -20]);
xlim([0.02 10]);
grid on
%%
% FFT de ambas señales ORIGINAL Y DERECHA
figure(4)
L1=length(y1);
NFFT1 = 2^nextpow2(L1);% t señal original 65536 = 2^16 Y1 = t(y1,NFFT1)/L1;
% (anecoica) 65536
LIN1=linspace(0,1,NFFT1/2+1);% 1 a 32769 = [0,3E-5,6E-5,...
f1 = fs/2*LIN1;% 1 A 32769 = [0,0.67,1.34,...
L3R=length(y3R);% 268499
NFFT3R = 2^nextpow2(L3R);% t señal convolucionada 524288 = 2^19 Y3R = t(0.2*y3R,NFFT3R)/L3R;
% (auralizada)
LIN3R=linspace(0,1,NFFT3R/2+1);
f3R = fs/2*LIN3R;
plot(f1,2*abs(Y1(1:NFFT1/2+1)),'b');
hold on
plot(f3R,2*abs(Y3R(1:NFFT3R/2+1)),'r'); %grácos
hold off
axis([0 1000 0 1.8E-3])
legend('Original','Convolucionada')
title('Espectro de ORIGINAL vs CONVOLUCIONADA DERECHA')
xlabel('Frequencia (Hz)') ylabel('|Y(f)|') grid on
%%
% FFT de ambas señales ORIGINAL e IZQUIERDA
figure(5)
L3L=length(y3L);% 268499
NFFT3L = 2^nextpow2(L3L);% t señal convolucionada 524288 = 2^19
Y3L = fft(0.2*y3L,NFFT3L)/L3L;% (auralizada)
LIN3L=linspace(0,1,NFFT3L/2+1);
f3L = fs/2*LIN3L;
plot(f1,2*abs(Y1(1:NFFT1/2+1)),'b');
hold on
plot(f3L,2*abs(Y3L(1:NFFT3L/2+1)),'r'); %grácos
hold off
axis([0 1000 0 1.8E-3])
legend('Original','Convolucionada')
title('Espectro de ORIGINAL vs CONVOLUCIONADA IZQUIERDA')
xlabel('Frequencia (Hz)')
ylabel('|Y(f)|')
grid on