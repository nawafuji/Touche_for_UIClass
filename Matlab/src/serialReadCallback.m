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
global Average
global showAverage
global showText
global showGraph
global showAxis

% Cell container for color and label for each class
classColor = {'r','g','b','m','c'};
classLabel = {'No Touch','Correct','Grasping','Finger In','Drunk Up'};


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
            
            if(isTrained == 0)
                %plot new data
                plot(Freq, Voltage,'k-','LineWidth',5);
                axis([0 NumOfData 0 4096]);
                xlabel('Step of Frequency [ ]');
                ylabel('Voltage [mV]');
                drawnow
            % execute classification after finishing training
            elseif(isTrained == 1)
                tmpclass = 0;
                maxScore = 0;
                % calculate score for each class
                for j = 1:NumOfClass;
                    [label,score] = predict(svmClassifier{j},Voltage');
                    % score = [falserate truerate]
                    % take the highest score (truerate)
                    if(maxScore < score(1,2))
                        tmpclass = j;
                        maxScore = score(1,2);
                    end
                end
                % show graph of test data or not
                if(showGraph == 1)
                    plot(Freq, Voltage,'k-','LineWidth',5);
                    hold on
                end
                % show graph of training data or not
                if(showAverage == 1)
                    for i=1:NumOfClass
                        plot(Freq, Average(:,i),strcat(char(classColor(i)),'-'),'LineWidth',3);
                        hold on
                    end
                end
                % set axis
                axis([0 NumOfData 0 4096]);
                % show axis or not
                if (showAxis == 0)
                    axis off
                else
                    xlabel('Step of Frequency [ ]');
                    ylabel('Voltage [mV]');
                end
                if(tmpclass ~= 0)
                    % display classification result
                    if(showText == 1)
                        text(100,500,char(classLabel(tmpclass)),'Fontsize',160,'HorizontalAlignment','center','Color',char(classColor(tmpclass)));
                    end
                end
                hold off
                % draw here
                drawnow
            end
        end
    end
end
end
