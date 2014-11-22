close all

x1 = 1:10; %Some data size 10
y1 = x1.^2; %Some data size 10


x2 = linspace(1,10,20); %Some data size 20, with different x-axis
y2 = x2.^2; %Some data size 20, with different x-axis

y2interp=interp1(x2,y2,x1); %Interpolate y2 data onto x1 axis

subplot(1,2,1);plot(x1,y1,'bo-',x2,y2,'r+-');
legend('y1','y2','Location','North')
title('Original data for y1 and y2')
subplot(1,2,2);plot(x1,y1,'bo-',x1,y2interp,'r+-');
legend('y1','y2','Location','North')
title('Interpolated data for y2 plotted over y1')
