%--------------------------------------------------------------------
% Make svm classifier
%--------------------------------------------------------------------

function SVMModels = makeClassifier(filename, classNum)

% making cell container for svm classifier
SVMModels = cell(classNum,1);
rng(1);

% all = [class ,data]
all = dlmread(filename);
data = all(:,2:end);
class = all(:,1);

% Create classifier for each class
for j = 1:classNum;
    % Create binary classes for each classifier
    indx = (class == j);
    SVMModels{j} = fitcsvm(data,indx);
end;