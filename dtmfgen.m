function y = dtmfgen(bits)
key = bits;
lfg = [1000 1700]; % Low frequency group
hfg = [2800 3500];  % High frequency group
f = [];
fs = 8000;
for c=1:2,
   for r=1:2
          f = [ f [lfg(c);hfg(r)] ];
   end
end

concat = [];
for i = 1:size(key,2)
    duration = 0.2;
    t = 0:1/fs:duration;
    temp = key(i);
    freq = f(:,temp);
    sig_1 = sin(2*pi*freq(1)*t);
    sig_2 = sin(2*pi*freq(2)*t);
    sil_dur=0.2;
    sil_freq=0;
    sil_tt=0:(1/fs):duration;
    sil_tone=sin(2*pi*sil_freq*sil_tt);
    %soundsc(sig_1+sig_2);
    %soundsc(sil_tone);
    %pause(0.3)
    concat = [concat,sig_1+sig_2, sil_tone];
    
end
%soundsc(concat);

y = concat;
end