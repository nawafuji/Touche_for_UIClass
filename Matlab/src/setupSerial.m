%--------------------------------------------------------------------
% Set up serial connection with arduino
%--------------------------------------------------------------------

function [s,flag] = setupSerial(comPort)

flag = 1;
s = serial(comPort);
%set(s, 'DataBits', 8);
%set(s, 'StopBits', 1);
set(s, 'BaudRate', 57600);
set(s, 'Parity', 'none');
set(s, 'InputBufferSize', 1024);
s.BytesAvailableFcnMode = 'byte';
s.BytesAvailableFcnCount = 804;
s.BytesAvailableFcn = @serialReadCallback;
fopen(s);

end