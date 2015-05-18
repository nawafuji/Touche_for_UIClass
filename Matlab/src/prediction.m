function prediction(SVMModels, testdata)

if predict(SVMModels{1},testdata)==1
    disp('Not Holding');
elseif predict(SVMModels{2},testdata)==1
    disp('Holding with two fingers');
elseif predict(SVMModels{3},testdata)==1
    disp('Holding in hand');
elseif predict(SVMModels{4},testdata)==1
    disp('Dipping finger');
else
    disp('Error');
end