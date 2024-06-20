clear; clear all; clc;
pkg load communications
input_string = input('Enter the string less than 30 : ', 's');  % 's'는 문자열로 입력을 받겠다
if length(input_string) > 30
    error('error : Too much string');
    return;
else
    bit_string = stringtobits(input_string);
    disp(bit_string);
end

Rb = 400; Fc = 1000; L=16; EbN0dB = 4;
f1=1000;f2=1500;
while true
    disp('fixed data : Carrier frequency: 1 kHz, bit rate: 400, oversampling factor: 16');
    
    switch user_input = input('1 is BPSK, 2 is BASK, 3 is BFSK or 0 is exit ');
        case 1
            disp('you have chosen BPSk modulation');
            disp('\n');
            disp('\n');
            
            BPSK_signal(bit_string,Fc,Rb,L,EbN0dB);
            
            break;
        case 2
            disp('you have chosen BASk modulation');
            disp('\n');
            disp('\n');
            
            BASK_signal(bit_string, Rb, Fc, L, EbN0dB);
            
            break;
        case 3
            disp('you have chosen BFSk modulation');
            disp('\n');
            disp('\n');
                        
            BFSK_signal(bit_string, Rb, Fc, L, EbN0dB,f1,f2)
            
            break;
        case 0
            disp('Exit');
            return;
        otherwise
            disp('error : you must enter the vaild number which is 1, 2, 3 or 0 ');
    end
end
