# 디지털 송수신 시뮬레이터 시스템 구현

&nbsp;

&nbsp;
## 💪 프로젝트 소개
BPSK, BFSK, BASK 변복조 시스템 중에 하나를 골라 원하는 문자열을 비트열로 만듭니다.
그리고, 이를 시스템에 맞게 변조시킨 후, 가상의 백색잡음을 통과하여, 복조시킨 후, 다시 문자열로 만듭니다. 
&nbsp;

<B>세 변복조 시스템이 백색잡음 속에서 얼마나 오류가 적은지를 확인하기 위해, 수신신호의 파형과 스펙트럼을 출력하는 프로그램이다.</B>

&nbsp;

&nbsp;
## 😄 주요 기능
* 30자 내의 문자열을 입력받아 비트열로 변환
* 변복조 시스템을 입력받아, NRZ 과정을 거치고, DSB 변조방식을 사용하여 대역으로 신호를 전송
* AWGN 채널을 통과한다
* 대역신호를 기저신호로 바꾸는 DSB 복조과정을 거쳐, 임펄스 트레인과 컨볼루션 오버샘플링 인자 단위로 샘플링한후, 오버샘플링 단위로 샘플들을 합친다.
* 해당 샘플들에서 0보다 큰 비트들을 1로 판정하여 비트열을 복원한다
* 해당 비트열을 문자열로 다시 출력한다

각 소스파일은 다음과 같은 구성을 가집니다

![image](https://github.com/user-attachments/assets/1ad7c820-80f3-4971-a0f4-92c63d28becb)

&nbsp;

&nbsp;
## ℹ️ 개발 정보
* 개발기간 : 23.05.08 ~ 06.03
* 개발인원 : 류성수 (dbtjdtn325@gmail.com)
* 개발환경 : Octave
&nbsp;

&nbsp;
## 🤔 요구 사항
* MATLAB (or OCTAVE)

&nbsp;

&nbsp;
## 🙏 설치 및 실행방법
  1. 먼저 레포지토리를 clone 합니다
  ```sh
  git clone https://github.com/supergravityy/Digital_communication.git
  ```
  2. 파일의 main.m을 실행합니다
  
  3. 커맨드 창에 30자 이내의 문자열을 입력합니다
  ![스크린샷 2024-06-25 160937](https://github.com/dcop94/Repowith/assets/145382604/b35a4d29-2596-4568-83cc-1844bd542e5f)
  4. 원하는 변복조 시스템을 선택합니다
  ![스크린샷 2024-06-25 161002](https://github.com/dcop94/Repowith/assets/145382604/32a552db-d004-48bf-8cf2-e7d7512c28d1)
  5. 백색잡음 속에서 입력한 문자열이 나왔는지 확인합니다
  ![스크린샷 2024-06-25 161037](https://github.com/dcop94/Repowith/assets/145382604/668ff6b7-a869-4b76-a397-66e945fd959b)
&nbsp;

&nbsp;
## 🤷‍♂️ 프로그램 동작
```여기서는 BPSK 변복조 시스템을 사용하였습니다```

![스크린샷 2024-06-25 161018](https://github.com/dcop94/Repowith/assets/145382604/f341fa34-e1e2-460d-a792-fd9534928208)
![스크린샷 2024-06-25 161026](https://github.com/dcop94/Repowith/assets/145382604/d64b8b39-2319-4cd8-a2f2-0d4b5a36f91a)
