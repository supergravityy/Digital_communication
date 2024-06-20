function BASK_signal(bit_string, Rb, Fc, L, EbN0dB)
  Fs = L * Rb;  
  N = length(bit_string);  
  EbN0linear = 10.^(EbN0dB/10);  
  BER = zeros(length(EbN0dB),1);  
  ak=bit_string;
  
  % BASK ����
  s_bb = repmat(bit_string, L, 1);
  s_bb = s_bb(:).';
  
  % �ݼ��� ���ϱ�
  t = (0:(length(s_bb)-1)) / Fs;
  s = s_bb .* cos(2*pi*Fc*t);  %�뿪��� ��ȣȭ
  
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

  % s�� �ϳ��� ��İ� ���⿡, ��Ʈ �ϳ��� ������ ������ �����ϱ�����, ��Ʈ �ϳ��� ������, 
  % �ٷ� �����ϴ� ���� �ý����� ������.
  for i = 1:length(EbN0dB)
    disp(['EbN0dB = ' num2str(EbN0dB(i))])
    Eb = sum(abs(s_bb).^2) / length(s_bb);  % ��Ʈ�� ������
    N0 = Eb / EbN0linear(i);  % ��������Ʈ�� �е� ���
    n = sqrt(N0/2) * (randn(1, length(s)));  % AWGNä�� ���
    r = s + n; % AWGNä�� ���
    
    % ���Ž�ȣ ����
    r_bb = r .* cos(2*pi*Fc*t);  % Baseband received signal
    x=real(r_bb); % r bb �� �Ǽ��� ��, x=r_bb�� �ǹ�.
    x = conv(x,ones(1,L)); % x�� ���޽� Ʈ���� ������� -> �׳� x
    x = x(L:L:end); % L�� ���ø�
    ak_cap = (x > 0).'; %�̴� ��ȣ�� �ִ밪�� ���ݺ��� ū ������ 1��, 
    % �׷��� ���� ������ 0���� ����.

    
    error_count = sum(ak ~= ak_cap.'); % ������Ʈ���� ������ �ٸ��� ����ī��Ʈ 
    
    ak_cap.'   %���� ��Ʈ�� ���
    disp('/n');
    disp('/n');
    disp(['Number of errors: ' num2str(error_count)]);
    disp('/n');
    BER(i) = error_count / N; % ��Ʈ ������ ���
    
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
