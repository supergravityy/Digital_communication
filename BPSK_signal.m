function BPSK_signal(bit_string, Rb, Fc, L, EbN0dB)
  % 주어진 비트열을 BPSK로 모듈레이션하고 AWGN 채널을 통과시킨 뒤 복조

  Fs = L * Rb;
  N = length(bit_string); % 전송할 비트 수
  EbN0linear = 10.^(EbN0dB/10); % dB 값을 선형 스케일로 변환
  BER = zeros(length(EbN0dB),1); % BER 값을 미리 저장할 벡터
  ak = bit_string; % 전송할 비트열

  % BPSK 모듈레이션
  s_bb = repmat(2*ak - 1, L, 1);
  s_bb = s_bb(:).';

  % 통과대역 BPSK 신호 생성
  t = (0:(length(s_bb)-1)) / Fs;
  s = s_bb .* cos(2*pi*Fc*t); % 대역 통과 BPSK 신호

  % 비트열, 기저대역 BPSK 신호, 통과대역 BPSK 신호를 그래프로 도시
  figure;
  subplot(3,1,1);
  plot(ak(1:10));
  title('Bit String');
  subplot(3,1,2);
  plot(s_bb);
  title('Baseband BPSK Signal');
  subplot(3,1,3);
  plot(s);
  title('Passband BPSK Signal');

  for i = 1:length(EbN0dB)
    disp(['EbN0dB =' num2str(EbN0dB(i))])
    Eb = sum(abs(s_bb).^2) / length(s_bb); % 비트 에너지
    N0 = Eb / EbN0linear(i); % 노이즈 스펙트럴 밀도 찾기
    n = sqrt(N0/2) * (randn(1, length(s))); % AWGN
    r = s + n;
  
    % 수신신호 복조
    r_bb = r .* cos(2*pi*Fc*t); % 기저대역 수신 신호
    x=real(r_bb); % r bb 가 실수일 땐, x=r bb를 의미.
    x = conv(x,ones(1,L)); % x와 임펄스 트레인 컨볼루션 -> 그냥 x
    x = x(L:L:end); % sample at every L point
    ak_cap = (x > 0).';
    
    % 원본과 일치하지 않는 비트 개수 확인
    error_count = sum(ak ~= ak_cap.');
    
    ak_cap.'    %복조 비트열 출력
    disp('\n');
    disp('\n');
    disp(['Number of errors: ' num2str(error_count)]);
    disp('\n');
    BER(i) = error_count / N; % 비트 에러율 계산

    % 수신 신호와 잡음 그래프를 도시
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
  disp(['BER: ' num2str(BER) '\n']);
  
  bitstostring(ak_cap.')
end