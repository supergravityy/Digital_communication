function bit_array = stringtobits(input_string)
    % 출력인 비트열 초기화
    bit_array = [];
    
    % 아스키(10진수)로 변환후, 2진변환
    for i = 1:length(input_string)
        ascii_val = double(input_string(i));
        bits = dec2bin(ascii_val, 8) - '0';  % 문자형은 1바이트이기에, 8비트형태로 변환
        % 또한 디지털 변복조 시스템에 이용하기 위해, 수로 변환
        bit_array = [bit_array, bits]; % 변환된 비트를 비트 배열에 추가
    end
end