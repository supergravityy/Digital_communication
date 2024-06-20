function BASK_signal(bit_string, Rb, Fc, L, EbN0dB)
  Fs = L * Rb;  
  N = length(bit_string);  
  EbN0linear = 10.^(EbN0dB/10);  
  BER = zeros(length(EbN0dB),1);  
  ak=bit_string;
  
  % BASK 변조
  s_bb = repmat(bit_string, L, 1);
  s_bb = s_bb(:).';
  
  % 반송파 곱하기
  t = (0:(length(s_bb)-1)) / Fs;
  s = s_bb .* cos(2*pi*Fc*t);  %대역통과 신호화
  
  figure;
  subplot(3,1,1);
  plot(ak(1:10));
  title('Bit String');
  subplot(3,1,2);
  plot(s_bb);
  title('Baseband BASK Signal');
  subplot(3,1,3);
  plot(s);
  title('Passband BASK Signal');

  % s는 하나의 행렬과 같기에, 비트 하나씩 보내는 구조를 구현하기위해, 비트 하나를 전송후, 
  % 바로 복원하는 복조 시스템을 구현함.
  for i = 1:length(EbN0dB)
    disp(['EbN0dB = ' num2str(EbN0dB(i))])
    Eb = sum(abs(s_bb).^2) / length(s_bb);  % 비트당 에너지
    N0 = Eb / EbN0linear(i);  % 잡음스펙트럼 밀도 계산
    n = sqrt(N0/2) * (randn(1, length(s)));  % AWGN채널 통과
    r = s + n; % AWGN채널 통과
    
    % 수신신호 복조
    r_bb = r .* cos(2*pi*Fc*t);  % Baseband received signal
    x=real(r_bb); % r bb 가 실수일 땐, x=r_bb를 의미.
    x = conv(x,ones(1,L)); % x와 임펄스 트레인 컨볼루션 -> 그냥 x
    x = x(L:L:end); % L로 샘플링
    ak_cap = (x > 0).'; %이는 신호의 최대값의 절반보다 큰 값들을 1로, 
    % 그렇지 않은 값들을 0으로 설정.

    
    error_count = sum(ak ~= ak_cap.'); % 복원비트열과 원본이 다르면 에러카운트 
    
    ak_cap.'   %복조 비트열 출력
    disp('/n');
    disp('/n');
    disp(['Number of errors: ' num2str(error_count)]);
    disp('/n');
    BER(i) = error_count / N; % 비트 에러율 계산
    
    figure;
    subplot(2,2,1);
    plot(n);
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
  bitstostring(ak_cap.')
end
