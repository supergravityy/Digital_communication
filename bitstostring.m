function text = bitstostring(bitstream)
  text = '';
  num_chars = floor(length(bitstream) / 8);
  % 비트 스트림의 길이를 8로 나누어서 문자의 개수를 계산, floor 함수를 사용하여 정수 부분만을 가짐
  
  for i = 1:num_chars %문자 개수만큼 반복
    start_idx = (i - 1) * 8 + 1; %현재 문자의 시작 인덱스를 계산
    end_idx = start_idx + 7; %현재 문자의 끝 인덱스를 계산. 
    %각 문자는 8비트로 구성되므로, 시작 인덱스부터 7을 더하여 끝 인덱스를 얻음
    char_bits = bitstream(start_idx:end_idx); 
    % 비트 스트림에서 현재 문자의 비트를 추출
    char_dec = bi2de(char_bits, 'left-msb');
    % 추출한 비트를 정수로 변환합니다. bi2de 함수를 사용하여 이진수를 십진수로 변환
    %'left-msb' 인수는 가장 왼쪽 비트를 가장 중요한 비트로 간주하는 것을 의미
    text = [text, char(char_dec)];
  end
  
  if mod(length(bitstream), 8) ~= 0
    % 비트 스트림의 길이가 8의 배수가 아닌 경우를 확인
    disp('Warning: Bitstream length is not a multiple of 8. Extra bits are ignored.')
  end
end