%--------------------------------------------------------------------
% Make average amplitude matrix of training data set
%--------------------------------------------------------------------

function Average = makeAverage(filename,numData,numClass)

all = dlmread(filename);
data = all(:,2:end); 
class = all(:,1); 
[cols,rows] = size(class);
average = zeros(numClass, numData);
dataCount = zeros(numClass,1);
for i=1:cols;
    classnum = class(i,1);
    average(classnum,:) = average(classnum,:) + data(i,:);
    dataCount(classnum,1) = dataCount(classnum,1) + 1;
end
for i=1:numClass;
    average(i,:) = ceil(average(i,:) ./ dataCount(i,1));
    Average = transpose(average);
end
