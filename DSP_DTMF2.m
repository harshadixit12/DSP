%% DSP project SEM 1 2018-19 - DTMF generation and decoding.
%Done by:
% Harsha P Dixit    2015B4A30583G
% Siddharth K V     2015B4A30434G
% Satyam Bhardwaj  2015B4A30597G

%Genertion of DTMF happens in function file dtmfgen.m
%%Digits and corresponding frequency pairs:

%     1  1000.00     2  1000.00    3   1700.00     4    1700.00
%        2800.00        3500.00        2800.00          3500.00

%Filters were created using kaiser window method as we got the least order 
%using it.
%% Filter 1 : Bandpass filter.
%Passband freq: 995 Hz, 1005 Hz. 
%Stopband freq: 800 Hz, 1200 Hz
fsamp = 8000;
fcuts = [800 995 1005 1200];
mags = [0 1 0];
devs = [0.03 0.01 0.03];
t = 0:1/fsamp:2;
[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,fsamp);
n
n = n + rem(n,2);
filt1 = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');

figure(1)
freqz(filt1)
title('Bandpass filter 1')
saveas(figure(1), 'filter1.png')
%% Filter 2 : Bandpass filter.
%Passband freq: 1695 Hz, 1705 Hz. 
%Stopband freq: 1500 Hz, 1900 Hz
fcuts2 = [1500  1695 1705 1900];
mags2 = [0 1 0];
devs2 = [0.03 0.01 0.03]; 
[n2,Wn2,beta2,ftype2] = kaiserord(fcuts2,mags2,devs2,fsamp);
n2
n2 = n2 + rem(n2,2);
filt2 = fir1(n2,Wn2,ftype2,kaiser(n2+1,beta2),'noscale');

figure(2)
freqz(filt2)
title('Bandpass filter 2')
saveas(figure(2), 'filter2.png')
%% Filter 3 : Bandpass filter.
%Passband freq: 2695 Hz, 2805 Hz. 
%Stopband freq: 2600 Hz, 3000 Hz
fcuts3 = [2600 2795 2805 3000];
mags3 = [0 1 0];
devs3 = [0.03 0.01 0.03];
[n3,Wn3,beta3,ftype3] = kaiserord(fcuts3,mags3,devs3,fsamp);
n3 = n3 + rem(n3,2);
filt3 = fir1(n3,Wn3,ftype3,kaiser(n3+1,beta3),'noscale');

figure(3)
freqz(filt3)
title('Bandpass filter 3')
saveas(figure(3), 'filter3.png')
%% Filter 4 : Bandpass filter.
%Passband freq: 3495 Hz, 3505 Hz. 
%Stopband freq: 3300 Hz, 3700 Hz
fcuts4 = [3300 3495 3505 3700];
mags4 = [0 1 0];
devs4 = [0.03 0.01 0.03];
[n4,Wn4,beta4,ftype4] = kaiserord(fcuts4,mags4,devs4,fsamp);
n4 = n4 + rem(n4,2);
filt4 = fir1(n4,Wn4,ftype4,kaiser(n4+1,beta4),'noscale');

figure(4)
freqz(filt4)
title('Bandpass filter 4')
saveas(figure(4), 'filter4.png')
%% Input and descision making. 
%Input digits:
%plot(f,20*log(abs(H))) %Input multiple digits
bits = input('Enter phone number in [1 2 3 4 ...] format: ');
digits = [];
for i = 1:size(bits,2)
    input_signal = dtmfgen(bits(i)); % Returns generated dtmf signal
    output1 = conv(input_signal, filt1); %Passing through filter 1
    output2 = conv(input_signal, filt2);
    output3 = conv(input_signal, filt3);
    output4 = conv(input_signal, filt4);

    d_out1=fft(output1);
    y_out1 = (fftshift(d_out1));
    %F = -100000:100:100000;
    Fs = 8000;
    dF_out = Fs/size(output1,2);                      % hertz
    f_out = -Fs/2:dF_out:Fs/2-dF_out;
    [temp_y1 temp_x] = max(20*log(abs(y_out1)/size(output1,2)));
    freq_1 = abs(f_out(temp_x)); %Returns frequency with minimum 
    %attenuation in output1. Also temp_y1 returns its attenuation.

    d_out2 = fft(output2);
    y_out2 = (fftshift(d_out2));
    dF_out2 = Fs/size(output2,2);                      % hertz
    f_out2 = -Fs/2:dF_out2:Fs/2-dF_out2;
    [temp_y2 temp_x2] = max(20*log(abs(y_out2)/size(output2,2)));
    freq_2 = abs(f_out2(temp_x2)); %Returns frequency with minimum 
    %attenuation in output2. Also temp_y2 returns its attenuation.


    d_out3=fft(output3);
    y_out3 = (fftshift(d_out3));
    dF_out3 = Fs/size(output3,2);                      % hertz
    f_out3 = -Fs/2:dF_out3:Fs/2-dF_out3;
    [temp_y3 temp_x3] = max(20*log(abs(y_out3)/size(output3,2)));
    freq_3 = abs(f_out3(temp_x3));  %Returns frequency with minimum 
    %attenuation in output3. Also temp_y3 returns its attenuation.



    d_out4=fft(output4);
    y_out4 = (fftshift(d_out4));
    dF_out4 = Fs/size(output4,2);                      % hertz
    f_out4 = -Fs/2:dF_out4:Fs/2-dF_out4;
    [temp_y4 temp_x4] = max(20*log(abs(y_out4)/size(output4,2)));
    freq_4 = abs(f_out4(temp_x4));  %Returns frequency with minimum 
    %attenuation in output4. Also temp_y4 returns its attenuation.


    %Descision making : To decide the frequency components based on
    %attenuation values. 30dB attenuation chosen based on frequency
    %spectrum of dtmf signals.
    %Check for digit 1 - Outputs of filter 1 and 3.
    if((temp_y1 > -30) & (temp_y3 > -30))
        digits = [digits,1];
    end
    %Check for digit 2 - Outputs of filter 1 and 4.
    if((temp_y1 > -30) & (temp_y4 > -30))
        digits = [digits,2];
    end    
    %Check for digit 3 - Outputs of Filter 2 and 3.
    if((temp_y2 > -30) & (temp_y3 > -30))
        digits = [digits,3];
    end 
    %Check for digit 4 - Outputs of Filter 2 and 4.
    if((temp_y2 > -30) & (temp_y4 > -30))
        digits = [digits,4];
    end 
end
disp('Digits dialled: ')
disp(digits);

%% To play DTMF tones of digits dialled
output = dtmfgen(bits);
soundsc(output);