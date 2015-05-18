function plotLines(filename,testdata)

all = dlmread(filename);
data = all(:,2:end); %160*200 matrix
class = all(:,1); %160*1 matrix

data1 = [];
data2 = [];
data3 = [];
data4 = [];

for i=1:200;
    data1(i)=0;
    data2(i)=0;
    data3(i)=0;
    data4(i)=0;
    for j=1:40;
        data1(i)=data1(i)+data(j,i);
        data2(i)=data2(i)+data(j+40,i);    
        data3(i)=data3(i)+data(j+80,i);
        data4(i)=data4(i)+data(j+120,i);
    end
    data1(i)=data1(i)/40;
    data2(i)=data2(i)/40;
    data3(i)=data3(i)/40;
    data4(i)=data4(i)/40;
end
    
figure;
x = 1:200;
p = plot(x,data1(ceil(x)),'--',x,data2(ceil(x)),'--',x,data3(ceil(x)),'--',x,data4(ceil(x)),'--',x,testdata(ceil(x)));
xlabel('Frequency');
ylabel('Value');
