clc
%clear
close all
%%%% NI initial
daq.getDevices
s = daq.createSession('ni');
addAnalogOutputChannel(s,'Dev2','ao0','Voltage');

javaaddpath('sshfrommatlab_12_withPublicKeyAuth/ganymed-ssh2-build250.jar/ganymed-ssh2-build250.jar')
%%% ssh initial
channel  =  sshfrommatlab('lli','10.126.18.79','19661856','E:\PKUStudy\FlowTank\sshfrommatlab_12_withPublicKeyAuth\id_rsa');
[a,b] = sshfrommatlabissue(channel, 'recnode-control --camera 21990451 --configure "AcquisitionFrameRate=175.0"');
[a,b] = sshfrommatlabissue(channel, 'recnode-control --camera 21797353 --configure "AcquisitionFrameRate=175.0"');

%pause(10*60)  % relatex for one hour

% V = 0.2:0.02:0.4;
% S_test = [0.05
% 0.065
% 0.08
% 0.11
% 0.13
% 0.15
% 0.17
% 0.18
% 0.205
% 0.21
% 0.23
% ];


%%%%%%%%%%%%%%%%%%  2017. 11. 15  %%%%%%%%%%%%%%%%%%%
% V = 0.24:0.02:0.42;
% S_test= [0.1
% 0.12
% 0.135
% 0.145
% 0.16
% 0.175
% 0.205
% 0.215
% 0.22
% 0.24
% ];

%%%%%%%%%%%%%%%%%%  2017. 06. 12  %%%%%%%%%%%%%%%%%%%
% V = 0.24:0.02:0.5;
% S_test= [0.11
% 0.13
% 0.14
% 0.15
% 0.17
% 0.18
% 0.2
% 0.21
% 0.22
% 0.23
% 0.25
% 0.26
% 0.28
% 0.29
% ];

%%%%%%%%%%%%%%%%%%  2017. 07. 23  %%%%%%%%%%%%%%%%%%%
% V = 0.24:0.02:0.7;
% S_test= [
% 0.08
% 0.1
% 0.11
% 0.13
% 0.14
% 0.15
% 0.17
% 0.18
% 0.2
% 0.21
% 0.22
% 0.23
% 0.24
% 0.25
% 0.27
% 0.28
% 0.29
% 0.3
% 0.31
% 0.33
% 0.34
% 0.35
% 0.36
% 0.38
% ];

%%%%%%%%%%%%%%%%%%  2017. 08. 24  %%%%%%%%%%%%%%%%%%%
V = 0.24:0.02:0.7;
S_test= [
0.08
0.1
0.11
0.13
0.14
0.15
0.17
0.18
0.19
0.2
0.21
0.22
0.24
0.25
0.26
0.28
0.29
0.31
0.32
0.34
0.35
0.36
0.37
0.39
];


%%%%%%%%%%%%%%%% start For golden fish  %%%%%%%%%%%
% BL = 0.128;  % 20171011 two biggist   ********20171014************** 
% BL= (207 * 16.9 / 345.02)/100 ;  % 20171012 two smaller ones with colors on the back 
%BL= (247.63 * 16.9 / 345.02)/100 ;  % 20171015 two smaller ones with colors on the back 
% BL = (131.53*16.9/345.02)/100;  % Stickerback
% BL = (218*16.9/345.02)/100;  % Golden Fish 4 smallers
% BL = (106.53*16.9/345.02)/100;   % Sunbleak
% % BL = (400*16.9/345.02)/100;  % Roach
% BL = (330*16.9/345.02)/100;     %  GoldFish 2017.12.15
% BL = (320*16.9/345.02)/100;     %  GoldFish 2017.12.16
% BL = (350*16.9/345.02)/100;     %  GoldFish 2017.12.17
% BL = (300*16.9/345.02)/100;     %  GoldFish 2017.12.18
% BL = (295*16.9/345.02)/100;     %  GoldFish 2017.12.19
% BL = (320*16.9/345.02)/100;     %  GoldFish 2017.12.20
% BL = (260*16.9/345.02)/100;     %  GoldFish 2017.12.21
% BL = (210*16.9/345.02)/100;     %  GoldFish 2018.01.04
% BL = (323.64*25/530)/100;     %  GoldFish 2018.06.12
% BL = (370*25/530)/100;     %  GoldFish 2018.06.13 noll
% BL = (420*25/530)/100;     %  GoldFish 2018.06.14 three fish
%BL = (400*25/530)/100;     % GoldFish 2018.06.15 three fish
% BL = (400*25/530)/100;     % GoldFish 2018.06.16  No-LL
%BL = (400*25/530)/100;     % GoldFish 2018.06.17  No-LL  two fish from 2018.06.15 three fish
% BL = (420*25/530)/100;     %  GoldFish 2018.06.18 No-Vision two fish from 2018.06.14 three fish
% BL = (430*25/530)/100;     %  GoldFish 2018.06.18 No-Vision and No-LL two fish from 2018.06.14 three fish
% BL = (430*25/530)/100;     %  GoldFish 2018.07.04 No-Vision test two fish from 2018.06.14 three fish
%BL = (390*25/530)/100;     % Goldfish 2018.07.23 No-LL 
%BL = (410*25/530)/100;     % Goldfish 2018.07.24 No-LL 
%BL = (370*25/530)/100;     % Goldfish 2018.07.25 No-LL 
% BL = (377*25/530)/100;     % Goldfish 2018.07.26 No-LL-No-Vision
% BL = (395*25/530)/100;     % Goldfish 2018.07.27 No-LL-No-Vision
% BL = (408*25/530)/100;     % Goldfish 2018.07.30 No-LL-No-Vision
% BL = (390*25/530)/100;     % Goldfish 2018.07.31 No-Vision
%BL = (395*25/530)/100;     % Goldfish 2018.08.01 No-Vision / useless because of the recording system failed
% BL = (390*25/530)/100;     % Goldfish 2018.08.02 No-Vision
% BL = (390*25/530)/100;     % Goldfish 2018.08.03 No-Vision
% BL = (420*25/530)/100;     % Goldfish 2018.08.24 No-Vision
BL = (430*25/530)/100;     % Goldfish 2018.08.27 No-Vision

%%%%%%%%%%%%%%%% end For golden fish  %%%%%%%%%%%

%%%%%%%%%%%%%%%%  Roach  %%%%%%%%%%%%%%%%%
% BL = (400*16.9/345.02)/100;  % Roach
%%%%%%%%%%%%%%%% End  Roach  %%%%%%%%%%%%%%%%%

% pause(60*00) % relax 30 mins

repeat = 8*6 ;

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end

Obj=serial('com8','baudrate',9600);
fopen(Obj);
pause(60)  % 60 seconds

for i = 1:repeat
    fwrite(Obj,int8(1)); % start laser
    pause(30)  % 60 seconds
    
    outputSingleScan(s,0.35); % speed control (100 rpm)
    pause(10)  % 60 seconds
    
    [a,b] = sshfrommatlabissue(channel, ['recnode-control --start --code hq-gray --filename '  'GoldFish_PIV_100rpm_175Hz']);
    disp(['Repeat=',num2str(i)]);
    t_pause = 30*60;   % 5 mins recording
    t_recording = t_pause;  
    pause(t_recording)  % 5 mins rest
    [a,b] = sshfrommatlabissue(channel, 'recnode-control --stop');

    fwrite(Obj,int8(2)); % end laser
    outputSingleScan(s,0)  % Stop
    [a,b] = sshfrommatlabissue(channel, 'recnode-control --copy-location recnode@10.126.19.20::recordings/r-alien02 --copy --copy-delete-after');
    pause(t_pause/5); % Random rest from 5 to 10 min

end

fclose(Obj);





