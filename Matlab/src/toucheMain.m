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
global showAverage      % Flag indicating if Average is showed
global showText         % Flag indicating if Text is showed
global showGraph        % Flag indicating if Graph is showed
global showAxis         % Flag indicating if Axis of Graph is showed

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
showGraph = 1;
showAverage = 0;
showText = 1;
showAxis = 0;

%--------------------------------------------------------------------
% Callback setting 
%--------------------------------------------------------------------

% set up serial connection with arduino
% check arduino IDE for valid connection path
[s, flag] = setupSerial('/dev/cu.usbmodem1451');

% set up figure with key press callback
figure('KeyPressFcn',@keyPressedCallback,'Color','white','Menu','none');
axis off;
%--------------------------------------------------------------------
% Main loop
%--------------------------------------------------------------------

disp('-------------------------------------------------------');
disp('Press z key to toggle training');
disp('Press c key to stop running');
disp('Press a key to change setting to show average graph of training data');
disp('Press g key to change setting to show graph of test data');
disp('Press t key to change setting to show result of classification');
disp('-------------------------------------------------------');

while (1)
    pause(0.1);
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

