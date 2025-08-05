Com = 'com9';
% Com = '/dev/cu.usbmodem141211';

steps = 20;
xyz   = [0.01,0.01,0.01] ;

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end

Obj=serial(Com,'baudrate',9600);
fopen(Obj);
pause(0.5);
% pause(60)  % 60 seconds

Data2Send = [int16(254)];

% start flag
% fwrite(Obj,int16(254));
% pause(0.1);

for ixyz = 1:3
    sxyz = xyz(ixyz)*1000/steps;
    if sxyz>=0
        Data2Send=[Data2Send;(ones(steps,1))];
    else
        Data2Send=[Data2Send;(zeros(steps,1))];
    end
    Data2Send = [Data2Send;ones(steps,1)*abs(sxyz)];
    
end
Data2Send = [Data2Send;int16(255)];
fwrite(Obj,Data2Send);

DataRead = fread(Obj)

fclose(Obj);