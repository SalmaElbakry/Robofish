for idz = 1

dz = -5; % positive up  (this is speed)
id = 'leader'; %'leader' or 'follower'
StepCtr.dxyzCtr(0,0,dz,id,20);
StepCtr.fire;
pause(10);

end
