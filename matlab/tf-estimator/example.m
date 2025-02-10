clear variables;
close all;

% Data Input
data = readtable("tst.csv");
Time = data.Var1;
In = data.Var2;
Out = data.Var3;

% Get TF
[TF, Percent, SimOut] = estimateTF(Time, In, Out, 10, NaN);

% Save image and data
print('out/plot.png','-dpng')
print('out/plot.jpg','-djpeg')
print('out/plot.eps','-deps')
save("out/tf.mat", "TF", "SimOut", "Percent");