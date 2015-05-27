% -------------------------------------------------------------------
% Key press callback
% -------------------------------------------------------------------

function keyPressedCallback(src, event)

global Voltage
global svmClassifier
global isTrained
global NumOfClass
global NumOfData
global isFinish
global Average
global showAverage
global showText
global showGraph
global showAxis

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
        Average = makeAverage(filename,NumOfData,NumOfClass);
        disp('Training finished');
        disp('Switch touche to recognize gesture');
        
    % -------------------------------------------------------------------
    % g - graph visualization setting
    % -------------------------------------------------------------------
    case 'g'
        if (showGraph == 0)
            showGraph = 1;
        else
            showGraph = 0;
        end
    % -------------------------------------------------------------------
    % a - average graph visualization setting
    % -------------------------------------------------------------------
    case 'a'
        if (showAverage == 0)
            showAverage = 1;
        else
            showAverage = 0;
        end
    % -------------------------------------------------------------------
    % t - classification result visualization setting
    % -------------------------------------------------------------------
    case 't'
        if (showText == 0)
            showText = 1;
        else
            showText = 0;
        end
    % -------------------------------------------------------------------
    % g - axis visualization setting
    % -------------------------------------------------------------------
    case 'x'
        if (showAxis == 0)
            showAxis = 1;
        else
            showAxis = 0;
        end
end