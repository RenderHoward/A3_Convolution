
mmm = dlmread ('convolve_raw_0.dat');
y = linspace(0,(2+2/3)/1000, 9);
x = linspace( -3.7200, 3.7200, 187);
MMM = [round((mmm(:,1)+3.72)/0.04) + 1 ,round(mmm(:,2)*3000) + 1, mmm(:,3) ];

for i = 1:rows(MMM)
      z0(MMM(i,2),MMM(i,1)) = MMM(i,3);
endfor

[X,Y] = meshgrid(x,y);
figure
mesh(X,Y,z0);
title('convolve raw 0')

mmm = dlmread ('convolve_raw_1.dat');
y = linspace(0,1/300, 11);
x = linspace( -8.16, 8.16, 409);
MMM = [round((mmm(:,1)+8.16)/0.04) + 1 ,round(mmm(:,2)*3000) + 1, mmm(:,3) ];

for i = 1:rows(MMM)
      z1(MMM(i,2),MMM(i,1)) = MMM(i,3);
endfor

[X,Y] = meshgrid(x,y);
figure
mesh(X,Y,z1);
title('convolve raw 1')

conv = conv2(z0, z1);

x1 = linspace( -8.16 - (187/2)*0.04, 8.16 + (187/2) * 0.04, 595 );
y1 = linspace(-9/6000, 1/300+9/6000, 19);

[XX, YY] = meshgrid( x1, y1);
figure
mesh(XX, YY, conv)
title('convolution 01')