% -------------------------------------------------------------------
% Serial read callback
% -------------------------------------------------------------------

function serialReadCallback(obj,event)

global svmClassifier
global Voltage
global Freq
global isTrained
global NumOfClass
global NumOfData

% Cell container for color and label for each class
classColor = {'r','g','b','m','c'};
classLabel = {'No Touch','Correct','Brandy','Finger in','Drunk'};

% Start when enought data is stocked
% Data consist of 4 start byte (255) and 200 set of (freqMSB freqLSB volMS volLSB)

while(obj.BytesAvailable>=804)
    % detect first four 255 in order indicating the start bytes
    % first byte
    inByte =  fread(obj,1);
    if(inByte == 255)
        % second third forth byte
        inByte2 = fread(obj,3);
        if(inByte2(1)==255&&inByte2(2)==255&&inByte2(3)==255)
            % read data
            S = fread(obj, [4,NumOfData]);
            S = S';
            
            % column = [freqMSB freqLSB volMS volLSB]
            % merge MSB and LSB to one value
            Freq = bitor(bitsll(S(:,1), 8), S(:,2));
            Voltage = bitor(bitsll(S(:,3), 8), S(:,4));
            
            % plot new data
            plot(Freq, Voltage);
            axis([0 NumOfData 0 4096]);
            xlabel('Step of Frequency [ ]');
            ylabel('Voltage [mV]');
            drawnow
            
            % execute classification after finishing training
            if(isTrained == 1)
                class = 0;
                maxScore = 0;
                % calculate score for each class
                for j = 1:NumOfClass;
                    [label,score] = predict(svmClassifier{j},Voltage');
                    % score = [falserate truerate]
                    % take the highest score (truerate)
                    if(maxScore < score(1,2))
                        class = j;
                        maxScore = score(1,2);
                    end
                end
                if(class ~= 0)
                    % display classification result
                    text(100,3500,char(classLabel(class)),'Fontsize',32,'HorizontalAlignment','center','Color',char(classColor(class)));
                end
            end
        end
    end
end
end
