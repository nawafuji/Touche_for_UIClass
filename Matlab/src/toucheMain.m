%--------------------------------------------------------------------
% Main function for touche prototype with arduino due
%--------------------------------------------------------------------

clear all;

%--------------------------------------------------------------------
% Global instances
%--------------------------------------------------------------------

global DataReceived     % Flag indicating if data is received or not
global Voltage          % Vector for Voltage
global Freq             % Vector for Frequency
global isTrained        % Number of data (frequency resolution)
global NumOfData        % Number of Class
global NumOfClass       % Flag indicating if process should be stopped
global isFinish         % Flag indicating if training is finished

%--------------------------------------------------------------------
% Initialization of global instances
%--------------------------------------------------------------------

Voltage = zeros(200,1);
Freq = zeros(200,1);
DataReceived = 0;
NumOfData = 200;
NumOfClass = 5;
isFinish = 0;
isTrained = 0;

%--------------------------------------------------------------------
% Callback setting 
%--------------------------------------------------------------------

% set up serial connection with arduino
% check arduino IDE for valid connection path
[s, flag] = setupSerial('/dev/cu.usbmodem1451');

% set up figure with key press callback
figure('KeyPressFcn',@keyPressedCallback);

%--------------------------------------------------------------------
% Main loop
%--------------------------------------------------------------------

disp('-------------------------------------------------------');
disp('Press z key to toggle training');
disp('Press c key to stop running');
disp('-------------------------------------------------------');

while (1)
    pause(0.1);
    if(DataReceived == 1)
        % only for first time
        if(isFirst == 0)
            h = plot(Freq, Voltage);
            drawnow
            isFirst = 1;
            
        % refresh from second time
        else
            refreshdata(h)
            drawnow
        end
        DataReceived = 0;
    end
    % check finish flag
    if(isFinish == 1)
        break;
    end
end

%--------------------------------------------------------------------
% Finishing
%--------------------------------------------------------------------

% close serial connection and figure
fclose(s);
close;

