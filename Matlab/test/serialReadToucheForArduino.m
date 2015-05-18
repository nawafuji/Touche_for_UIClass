
function serialReadTouche(obj,event)
% 
global DataReceived
global Voltage
global Freq
global arrayNum
persistent TmpVoltage
persistent TmpFreq
persistent isFirst

while(obj.BytesAvailable>7)
    %disp(obj.BytesAvailable);
    inByte = fread(obj,1);
    if(inByte == 0)
        SerialInArray = [0; fread(obj, 7)];
        checksum = sum(SerialInArray)-SerialInArray(8);
        checksum = rem(checksum,255);
        if(checksum == SerialInArray(8))
            zeroByte = SerialInArray(7);
            xLSB = SerialInArray(4);
%             if(bitand(zeroByte, 1) == 1)
%                 xLSB = 0;
%             end
             xMSB = SerialInArray(3);
%             if(bitand(zeroByte, 2) == 2)
%                 xMSB = 0;
%             end
             yLSB = SerialInArray(6);
%             if(bitand(zeroByte, 4) == 4)
%                 yLSB = 0;
%             end
             yMSB = SerialInArray(5);
%             if(bitand(zeroByte, 8) == 8)
%                 yMSB = 0;
%             end

            command = SerialInArray(2);
            xValue = bitor(bitsll(xMSB,8), xLSB);
            yValue = bitor(bitsll(yMSB,8), yLSB);
            disp([command xValue yValue]);

            switch command
                case 1
                    arrayNum = arrayNum + 1;
                    TmpFreq(arrayNum) = xValue;
                    TmpVoltage(arrayNum) = yValue;
                    
                case 2
                    TmpVoltage = zeros(160, 1);
                    TmpFreq = zeros(160, 1);
                    arrayNum = 0;
                case 3
                    DataReceived = 1;
                    Freq = TmpFreq;
                    Voltage = TmpVoltage;
                   
                    disp(arrayNum);
                    %if(isFirst == 0)
                h = plot(Freq(1:arrayNum), Voltage(1:arrayNum));
                drawnow
                
               % isFirst = 1;
                   % else
                   %     refreshdata(h);
                    %    drawnow
                    %disp('aaaaaaa');
            end
        else
        end
        
    end
end
end
