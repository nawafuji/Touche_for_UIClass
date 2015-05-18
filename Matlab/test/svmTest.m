clear all;
filename1 = 'trainData1.txt';
filename2 = 'trainData2.txt';
filename3 = 'trainData3.txt';
filename4 = 'trainData4.txt';
all1 = dlmread(filename1);
all2 = dlmread(filename2);
all3 = dlmread(filename3);
all4 = dlmread(filename4);

all1train = all1(1:30,:);
all2train = all2(1:30,:);
all3train = all3(1:30,:);
all4train = all4(1:30,:);

all1test = all1(31:40,:);
all2test = all2(31:40,:);
all3test = all3(31:40,:);
all4test = all4(31:40,:);

alltest = [all1test;all2test;all3test;all4test];
alltrain = [all1train;all2train;all3train;all4train];
X = alltrain(:,2:end);
Y = alltrain(:,1);
load fisheriris
inds = ~strcmp(species,'setosa');
%X = meas(inds,3:4);
%Y = species(inds);
% It is good practice to define the class order and standardize the
% predictors.
SVMModels = cell(3,1);
classes = unique(Y);
rng(1); % For reproducibility

for j = 1:numel(classes);
    indx = Y == classes(j); % Create binary classes for each classifier
    %indx = strcmp(class,classes(j)); % Create binary classes for each classifier
    SVMModels{j} = fitcsvm(X,indx);
end;
%indx = (Y == classes(1)); % Create binary classes for each classifier
%SVMModels{1} = fitcsvm(X,indx,'ClassNames',[false true],'Standardize',true,'KernelFunction','rbf','BoxConstraint',1);
%SVMModels{1} = fitcsvm(X,indx);
% d = 0.02;
% [x1Grid,x2Grid] = meshgrid(min(X(:,1)):d:max(X(:,1)),...
%     min(X(:,2)):d:max(X(:,2)));
% xGrid = [x1Grid(:),x2Grid(:)];

N = 40;
Scores = zeros(N,numel(classes));
Labels = zeros(N,numel(classes));
for j = 1:numel(classes);
    [label,score] = predict(SVMModels{j},alltest(:,2:end));
    %disp(label);
    Scores(:,j) = score(:,2); % Second column contains positive-class scores
    Labels(:,j) = label(:,1);
end
