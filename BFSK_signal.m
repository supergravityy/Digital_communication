function BFSK_signal(bit_string, Rb, Fc, L, EbN0dB, f1, f2)
  Fs = L * Rb;  
  N = length(bit_string);  
  EbN0linear = 10.^(EbN0dB/10); 
  BER = zeros(length(EbN0dB),1); 
  ak = bit_string; % 전송할 비트열
  
  
  t = (0:L-1) / Fs;  % 비트 하나를 위한 시간
  s_bb = []; 
  %비트 하나씩 조건문을 통과시킨다
  for bit = ak
    if bit == 0
      s_bb = [s_bb, cos(2*pi*f1*t)];  % 0 -> f1
    else
      s_bb = [s_bb, cos(2*pi*f2*t)];  % 1 -> f2
    end
  end
  
  % Generation of passband signal
  t = (0:length(s_bb)-1) / Fs; 
  s = s_bb .* cos(2*pi*Fc*t); % 반송파 곱하기
  
  figure;
  subplot(3,1,1);
  plot(ak(1:10));
  title('Bit String');
  subplot(3,1,2);
  plot(s_bb);
  title('Baseband BFSK Signal');
  subplot(3,1,3);
  plot(s);
  title('Passband BFSK Signal');
  
  for i = 1:length(EbN0dB)
    disp(['EbN0dB = ' num2str(EbN0dB(i))])
    Eb = sum(abs(s_bb).^2) / length(s_bb);  
    N0 = Eb / EbN0linear(i);  
    noise = sqrt(N0/2) * (randn(1, length(s_bb)));  % AWGN 채널생성
    r = s + noise;
    
    % 복조
    r_bb = r .* cos(2*pi*Fc*t);  % DSB 복조를 일으킴
    ak_cap = [];
    % 비트 하나씩 푸리에 역변환의 메커니즘을 이용해 비트 복원
    for n = 1:L:length(r_bb)
      segment = r_bb(n:n+L-1);
      t_segment = (0:(L-1)) / Fs;
      
      % 서로 다른 주파수로 이뤄진 신호는 서로에게 직교하기에, 동기검파라고 가정후,
      % 신호에 내적해서, 비트를 추출한다 
      correlation1 = sum(segment .* cos(2*pi*f1*t_segment));
      correlation2 = sum(segment .* cos(2*pi*f2*t_segment));
      if correlation1 > correlation2
        ak_cap = [ak_cap, 0];
      else
        ak_cap = [ak_cap, 1];
        end
      end

    
    
    error_count = sum(bit_string ~= ak_cap);
    
    ak_cap    %복조 비트열 출력
    disp('/n');
    disp('/n');
    disp(['Number of errors: ' num2str(error_count)]);
    disp('/n');
    BER(i) = error_count / N; % 비트 에러율 계산
    
    figure;
    subplot(2,2,1);
    plot(noise);
    title('Noise');
    subplot(2,2,2);
    plot(r);
    title('Received Signal');
    subplot(2,2,3);
    plot(r_bb);
    title('Correlated Baseband Signal');
    subplot(2,2,4);
    plot(ak_cap(1:10));
    title('Demodulated Bit String');
  end
  
  disp(['BER: ' num2str(BER)]);
  bitstostring(ak_cap)
end
