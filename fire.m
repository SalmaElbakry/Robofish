Com = 'com10';
% Com = '/dev/cu.usbmodem141211';

newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end

Obj=serial(Com,'baudrate',9600);
fopen(Obj);
pause(2);
% pause(60)  % 60 seconds

int16(1)
fwrite(Obj,int16(1))

pause(0.5);

fwrite(Obj,int16(0));
fclose(Obj);