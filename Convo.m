function Convo()
  [ z0, x, y ] = read_mat('convolve_raw_0.dat');

  [X,Y] = meshgrid(x,y);
  figure
  mesh(X,Y,z0);
  title('convolve raw 0')

  [ z1, x, y ] = read_mat('convolve_raw_1.dat');

  [X,Y] = meshgrid(x,y);
  figure
  mesh(X,Y,z1);
  title('convolve raw 1')

  conv = conv2(z0, z1);

  x_step = (x(2) - x(1)); x_pad = size(z0,2)/2*x_step;
  y_step = (y(2) - y(1)); y_pad = size(z0,1)/2*y_step;
  
  % Domain enlarged by sum of sizes in each dimension
  x1 = linspace( min(x) - x_pad, max(x) + x_pad, size(z0,2) + size(z1,2) - 1 );
  y1 = linspace( min(y) - y_pad, max(y) + y_pad, size(z0,1) + size(z1,1) - 1 );

  [XX, YY] = meshgrid(x1, y1);
  figure
  mesh(XX, YY, conv);
  title('convolution 01')
end


function [z, x, y] = read_mat(name)
  mmm = dlmread(name);
  
  x_col = mmm(:,1);  y_col = mmm(:,2);
  
  maxx = max(x_col);  minx = min(x_col);
  
  uni_x = unique(x_col); uni_y = unique(y_col);
  
  maxy = max(mmm(:,2));  miny = min(mmm(:,2)); 
  
  step_x = uni_x(2) - uni_x(1);
  
  step_y = uni_y(2) - uni_y(1); 
  
  cnt_x = round((maxx - minx) / step_x) + 1;  cnt_y = round((maxy - miny) / step_y) + 1;
  
  y = linspace(miny, maxy, cnt_y);
  
  x = linspace(minx, maxx, cnt_x);
  
  % List of  [ col_index, row_index, z_height ]
  MMM = [round((x_col- minx)/step_x) + 1 ,round((y_col- miny)/step_y) + 1, mmm(:,3) ];

  z = zeros(cnt_y, cnt_x, 'double'); 
  
  for i = 1:rows(MMM)
        z(MMM(i,2),MMM(i,1)) = MMM(i,3);
  endfor
end