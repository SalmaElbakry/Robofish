% Com = '/dev/tty.usbmodem1414201';
%% 
clear all

Com_follower = 'com5';
Com_leader   = 'com6';

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end
clear Obj_leader Obj_follower


Obj_follower = serialport(Com_follower,9600);



frequency = 2; % frequency
amplitude = 18 ; % amplitude
phase = 0; % phase = 0.2*pi
leader_data = [10, int16(frequency*10), amplitude, phase, 255];


sp                   = daq.createSession('ni');
sp.Rate              = 5000;
addAnalogInputChannel(sp,'cDAQ1Mod1', 1, 'Current'); %% leader power
addAnalogInputChannel(sp,'cDAQ1Mod1', 0, 'Current');  %% follower power
addAnalogInputChannel(sp,'Dev1', 'ai1', 'Voltage');   %% leader force
addAnalogInputChannel(sp,'Dev1', 'ai0', 'Voltage');  %% follower force

sp.DurationInSeconds = 10; % 1 second


%pause(15);

%%
for i =1:1:3
    %% air before
    data_air_before = [];
    follower_data = [10, int16(frequency*10), amplitude, 10, 255];
    leader_data
    follower_data
    
    write(Obj_follower,follower_data,"uint8");
    
    pause(10);
    
    tstart = tic;
    tdata = sp.startForeground;
    telapsed = toc(tstart)
    
    data_air_before = [data_air_before, tdata];
    
    save(['D:\Liang Li\RobotGame\17062023\data_air_before_flow80_fre2_amp18_',num2str(i)], 'data_air_before');
    
    stop = [10,0,0,0,255];

    write(Obj_follower,stop,"uint8");
    
    
    %% move to water
    StepCtr.initEnv();
    
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 13 0 0 130';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171220_145703_12744_13033.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(30);
    
    
    %%
    data_water = [];
    for phase = 0:2:20
  %   for phase = 0:5:15
           
        
        follower_data = [10, int16(frequency*10), amplitude, phase, 255];
        leader_data
        follower_data
      
        write(Obj_follower,follower_data,"uint8");
        
        StepCtr.fire;
       
        pause(10);
        
        tstart = tic;
        tdata = sp.startForeground;
        telapsed = toc(tstart)
        
        data_water = [data_water, tdata];
        
        
        stop = [10,0,0,0,255];
 
        write(Obj_follower,stop,"uint8");
      
        pause(15);

    end
    
    save(['D:\Liang Li\RobotGame\17062023\data_all_flow00_fre2_amp18_',num2str(i)], 'data_water');
    
   
    figure
   for ii = 1:2
        plot(mean(data_water(:,ii:4:end))-mean(mean(data_water(:,ii:4:end))));
        hold on
   end
    pause(20);
    
    %% move to air
    StepCtr.initEnv();
    
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 13 0 0 -130';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171220_145703_12744_13033.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    pause(5);
    StepCtr.fire;
    pause(30);
    
    
    %% air after
    data_air_after = [];
    follower_data = [10, int16(frequency*10), amplitude, 10, 255];
    leader_data
    follower_data
  
    write(Obj_follower,follower_data,"uint8");
    
    pause(10);
    
    tstart = tic;
    tdata = sp.startForeground;
    telapsed = toc(tstart)
    
    data_air_after = [data_air_after, tdata];
    
    save(['D:\Liang Li\RobotGame\17062023\data_air_after_flow00_fre2_amp18_',num2str(i)], 'data_air_after');
    
    stop = [10,0,0,0,255];
    %     fwrite(Obj_follower,int16(stop));
    %     fwrite(Obj_leader,int16(stop));
    %     write(Obj_leader,stop,"uint8");
    write(Obj_follower,stop,"uint8");
    
    pause(30);
    
     figure
     for ii = 1:2
         plot(mean(data_water(:,ii:4:end)) - (mean(data_air_before(:,ii)) + mean(data_air_after(:,ii)))/2);
         hold on
    end
     
    pause(100);
end
% 
% %% show data
% figure
%  for ii = 1:2
% % %    plot((mean(water1(:,ii+2:4:end)) - mean(mean(air1_a(ii+2)) + mean(air1_b(ii+2))))./(mean(water1(:,ii:4:end))-mean(mean(air1_a(ii+2)) + mean(air1_b(ii+2)))));
% % %    hold on
% % %    plot((mean(water2(:,ii+2:4:end)) - mean(mean(air2_a(ii+2)) + mean(air2_b(ii+2))))./(mean(water2(:,ii:4:end))-mean(mean(air2_a(ii+2)) + mean(air2_b(ii+2)))));
% % %    hold on
% % %      plot((mean(water3(:,ii+2:4:end)) - mean(mean(air3_a(ii+2)) + mean(air3_b(ii+2))))./(mean(water3(:,ii:4:end))-mean(mean(air3_a(ii+2)) + mean(air3_b(ii+2)))));
% % %    hold on    
%      plot(mean(water1(:,ii:4:end)));%);
%      hold on
%      plot(mean(water2(:,ii:4:end)));
%     hold on
%      plot(mean(water3(:,ii:4:end)));
%     hold on
%  end
%%

%mean_data_drag = mean(data_drag);
% save('D:\Liang Li\RobotGame\10052023\data_air_before_1', 'data');

%mean_data = mean(data);
%save('D:\Liang Li\RobotGame\10052023\data_all_lamenerflow100_2', 'data');

%%mean_data_drag_1 = [mean_data_drag(1) mean_data_drag(2) mean_data_drag(3) mean_data_drag(4); mean_data_drag(5) mean_data_drag(6) mean_data_drag(7) mean_data_drag(8); mean_data_drag(9) mean_data_drag(10) mean_data_drag(11) mean_data_drag(12); mean_data_drag(13) mean_data_drag(14) mean_data_drag(15) mean_data_drag(16);mean_data_drag(17) mean_data_drag(18) mean_data_drag(19) mean_data_drag(20);mean_data_drag(21) mean_data_drag(22) mean_data_drag(23) mean_data_drag(24);mean_data_drag(25) mean_data_drag(26) mean_data_drag(27) mean_data_drag(28); mean_data_drag(29) mean_data_drag(30) mean_data_drag(31) mean_data_drag(32);mean_data_drag(33) mean_data_drag(34) mean_data_drag(35) mean_data_drag(36);mean_data_drag(37) mean_data_drag(38) mean_data_drag(39) mean_data_drag(40);mean_data_drag(41) mean_data_drag(42) mean_data_drag(43) mean_data_drag(44)];
%%mean_data_1 = [mean_data(1) mean_data(2) mean_data(3) mean_data(4); mean_data(5) mean_data(6) mean_data(7) mean_data(8); mean_data(9) mean_data(10) mean_data(11) mean_data(12); mean_data(13) mean_data(14) mean_data(15) mean_data(16);mean_data(17) mean_data(18) mean_data(19) mean_data(20);mean_data(21) mean_data(22) mean_data(23) mean_data(24);mean_data(25) mean_data(26) mean_data(27) mean_data(28); mean_data(29) mean_data(30) mean_data(31) mean_data(32);mean_data(33) mean_data(34) mean_data(35) mean_data(36);mean_data(37) mean_data(38) mean_data(39) mean_data(40);mean_data(41) mean_data(42) mean_data(43) mean_data(44)];

