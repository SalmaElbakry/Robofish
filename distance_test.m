for i =1:1:5
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 10 0 0 -100';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    
    StepCtr.fire;
    i
    pause(10);
    
    mode = ' distance';
    leader = true;
    follower = true;
    flag_return = false;
    distance = ' 10 0 0 100';
    filename = 'd:/Liang Li/RobotRepeatRealFish/data/StepMotorCtr_test_20171219_155218_2363_2815.csv';
    
    StepCtr.setStepCtr(filename, mode, leader, follower, flag_return, distance);
    
    StepCtr.fire;
    i
    pause(10);
end