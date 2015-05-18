function plotLines(filename, classNum)

all = dlmread(filename);
data = all(:,2:end); %160*200 matrix
class = all(:,1); %160*1 matrix

figure;
x = 0:200;
plot(x,data(x));