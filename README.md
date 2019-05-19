# DSP - DTMF
This project was done in partial fulfilment of course Digital Signal Processing
DTMF stands for Dual Tone Multi Frequency. 

When telephone was invented, signalling was done through rotary dials. The first dials worked by direct, forward action. The
pulses were sent as the user rotated the dial to the finger stop starting at a different position for each digit transmitted. It was recognized as early as the 1940s that faster, more accurate dialing could be done with push buttons. In 1963, the Bell System introduced to the public its dual-tone multi-frequency (DTMF) technology under the name Touch-Tone, which was
a trademark in the U.S. until 1984. The Touch-Tone system used push-button telephones. In the decades after 1963, pulse dialing was gradually phased out as the primary dialing method to the central office, but many systems still support rotary telephones today.

When you press the buttons on the keypad, a connection is made that generates two tones
at the same time. A “Row” tone and a “Column” tone. These two tones identify the key you
pressed to any equipment you are controlling.
For instance, if you dial "5" on your keypad, the signal sent to the telephone office will
have frequencies 770 Hz and 1336 Hz.
1.2 ASSUMPTIONS
To simplify the task of generation and decoding of DTMF signals, the following assumptions
have been made.
• DTMF signals for four digits are being generated and decoded.

Digits and corresponding frequency pairs:

     1  1000.00     2  1000.00    3   1700.00     4    1700.00
        2800.00        3500.00        2800.00          3500.00

METHODOLOGY
Design was done using Kaiser window method, as minimum order was obtained through this
method.

MATLAB IMPLEMENTATION
Four bandpass filters were designed, with the following specifications:
Sampling frequency = 8000 Hz
Maximum passband ripple = 0.01
Minimum stopband attenuation = 0.03 (30 dB)

Filter 1:
Passband: 995 Hz to 1005 Hz
Stopband: 800 Hz and 1200 Hz

Filter 2:
Passband: 1695 Hz to 1705 Hz
Stopband: 1500 Hz and 1900 Hz

Filter 3:
Passband: 2795 Hz to 2805 Hz
Stopband: 2600 Hz and 3000 Hz

Filter 4:
Passband: 3495 Hz to 3505 Hz
Stopband: 3300 Hz and 3700 Hz

Input was taken from user as a sequence of digits, and for every digit DTMF signal was generated using "dmtfgen.m" file. Generated signal was then passed through each of the filters, to see the attenuation. The output from filters gave minimum attenuation < 30 dB only when it had a frequency component in the passband of the filter. So, if attenuation was less than 30 dB in the output of Filter 1 and Filter 3, the decision was that dialed digit is 1. Similarly, if attenuation was less than 30 dB in both Filter 1 and Filter 4, dialed digit was 2. If attenuation was less than 30 dB in both Filter 2 and Filter 3, dialed digit was 3. If attenuation was less than 30 dB in both Filter 2 and Filter 4 dialed digit was 4. 30 dB was chosen as threshold for attenuation by observing the frequency spectra of DTMF signals.

RESULTS
DTMF signals were generated and decoded successfully using MATLAB

