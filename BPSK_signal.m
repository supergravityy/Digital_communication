function BPSK_signal(bit_string, Rb, Fc, L, EbN0dB)
  % �־��� ��Ʈ���� BPSK�� ��ⷹ�̼��ϰ� AWGN ä���� �����Ų �� ����

  Fs = L * Rb;
  N = length(bit_string); % ������ ��Ʈ ��
  EbN0linear = 10.^(EbN0dB/10); % dB ���� ���� �����Ϸ� ��ȯ
  BER = zeros(length(EbN0dB),1); % BER ���� �̸� ������ ����
  ak = bit_string; % ������ ��Ʈ��

  % BPSK ��ⷹ�̼�
  s_bb = repmat(2*ak - 1, L, 1);
  s_bb = s_bb(:).';

  % ����뿪 BPSK ��ȣ ����
  t = (0:(length(s_bb)-1)) / Fs;
  s = s_bb .* cos(2*pi*Fc*t); % �뿪 ��� BPSK ��ȣ

  % ��Ʈ��, �����뿪 BPSK ��ȣ, ����뿪 BPSK ��ȣ�� �׷����� ����
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
    Eb = sum(abs(s_bb).^2) / length(s_bb); % ��Ʈ ������
    N0 = Eb / EbN0linear(i); % ������ ����Ʈ�� �е� ã��
    n = sqrt(N0/2) * (randn(1, length(s))); % AWGN
    r = s + n;
  
    % ���Ž�ȣ ����
    r_bb = r .* cos(2*pi*Fc*t); % �����뿪 ���� ��ȣ
    x=real(r_bb); % r bb �� �Ǽ��� ��, x=r bb�� �ǹ�.
    x = conv(x,ones(1,L)); % x�� ���޽� Ʈ���� ������� -> �׳� x
    x = x(L:L:end); % sample at every L point
    ak_cap = (x > 0).';
    
    % ������ ��ġ���� �ʴ� ��Ʈ ���� Ȯ��
    error_count = sum(ak ~= ak_cap.');
    
    ak_cap.'    %���� ��Ʈ�� ���
    disp('\n');
    disp('\n');
    disp(['Number of errors: ' num2str(error_count)]);
    disp('\n');
    BER(i) = error_count / N; % ��Ʈ ������ ���

    % ���� ��ȣ�� ���� �׷����� ����
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