function text = bitstostring(bitstream)
  text = '';
  num_chars = floor(length(bitstream) / 8);
  % ��Ʈ ��Ʈ���� ���̸� 8�� ����� ������ ������ ���, floor �Լ��� ����Ͽ� ���� �κи��� ����
  
  for i = 1:num_chars %���� ������ŭ �ݺ�
    start_idx = (i - 1) * 8 + 1; %���� ������ ���� �ε����� ���
    end_idx = start_idx + 7; %���� ������ �� �ε����� ���. 
    %�� ���ڴ� 8��Ʈ�� �����ǹǷ�, ���� �ε������� 7�� ���Ͽ� �� �ε����� ����
    char_bits = bitstream(start_idx:end_idx); 
    % ��Ʈ ��Ʈ������ ���� ������ ��Ʈ�� ����
    char_dec = bi2de(char_bits, 'left-msb');
    % ������ ��Ʈ�� ������ ��ȯ�մϴ�. bi2de �Լ��� ����Ͽ� �������� �������� ��ȯ
    %'left-msb' �μ��� ���� ���� ��Ʈ�� ���� �߿��� ��Ʈ�� �����ϴ� ���� �ǹ�
    text = [text, char(char_dec)];
  end
  
  if mod(length(bitstream), 8) ~= 0
    % ��Ʈ ��Ʈ���� ���̰� 8�� ����� �ƴ� ��츦 Ȯ��
    disp('Warning: Bitstream length is not a multiple of 8. Extra bits are ignored.')
  end
end