% -------------------------------------------------------------------
% Key press callback
% -------------------------------------------------------------------

function keyPressedCallback(src, event)

global Voltage
global svmClassifier
global isTrained
global NumOfClass
global isFinish

filename = '../data/trainingData.txt';
filename1 = '../data/notouch.txt';
filename2 = '../data/twofinger.txt';
filename3 = '../data/grasping.txt';
filename4 = '../data/sinking.txt';
filename5 = '../data/nowater.txt';

switch event.Character
    
    
    % -------------------------------------------------------------------
    % 1~5 - record training data
    % -------------------------------------------------------------------
    case '1'
        dlmwrite(filename1, [1 Voltage'] , '-append', 'delimiter', ' ');
    case '2'
        dlmwrite(filename2, [2 Voltage'] , '-append', 'delimiter', ' ');
    case '3'
        dlmwrite(filename3, [3 Voltage'] , '-append', 'delimiter', ' ');
    case '4'
        dlmwrite(filename4, [4 Voltage'] , '-append', 'delimiter', ' ');
    case '5'
        dlmwrite(filename5, [5 Voltage'] , '-append', 'delimiter', ' ');
        
    % -------------------------------------------------------------------
    % c - stop the code
    % -------------------------------------------------------------------
    case 'c'
        isFinish = 1;
        
    % -------------------------------------------------------------------
    % z - training classifier
    % -------------------------------------------------------------------
    case 'z'
        svmClassifier = makeClassifier(filename, NumOfClass);
        isTrained = 1;
        disp('Training finished');
        disp('Switch touche to recognize gesture');
end