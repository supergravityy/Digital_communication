function bit_array = stringtobits(input_string)
    % ����� ��Ʈ�� �ʱ�ȭ
    bit_array = [];
    
    % �ƽ�Ű(10����)�� ��ȯ��, 2����ȯ
    for i = 1:length(input_string)
        ascii_val = double(input_string(i));
        bits = dec2bin(ascii_val, 8) - '0';  % �������� 1����Ʈ�̱⿡, 8��Ʈ���·� ��ȯ
        % ���� ������ ������ �ý��ۿ� �̿��ϱ� ����, ���� ��ȯ
        bit_array = [bit_array, bits]; % ��ȯ�� ��Ʈ�� ��Ʈ �迭�� �߰�
    end
end