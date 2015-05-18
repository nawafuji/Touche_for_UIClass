clear all

a=0;
s = serial('COM5');
set(s, 'BaudRate', 38400);
set(s, 'Parity', 'none');

fopen(s);
while(s.BytesAvailable==0)
end
while(1)
    if(s.BytesAvailable>8)
    inByte = fread(s, 8);
    disp(inByte);
    a=a+1;
    if(a==160*8)
        disp(s.BytesAvailable);
        a=0;
    end
    end
end
