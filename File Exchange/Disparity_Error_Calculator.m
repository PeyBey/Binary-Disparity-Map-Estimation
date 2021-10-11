clc
close all
clear
gt = imread('D:\groundtruth.pgm');
result = imread('D:\Venus_paper.png');
%nonocclusion = imread('D:\Teddy\Teddy_nonocc.png'); % for non occlusion
%errresult = imread('D:\Teddy\Teddy_nonocc.png'); % for err map results
[x,y] = size(gt);
r = 0;
errmap = zeros(x,y);
%gt = rgb2gray(gt);
%result = rgb2gray(result);
gt = double(gt);
result = double(result);
%gt = gt./4; %for Teddy & Cones
%gt = gt./16; %for Tsukuba
gt = gt./8; %for Venus
%%%%%%%%%% if your result range is about 0 to 255 %%%%%%%%%%%
%result = result./4; %for Teddy & Cones
%result = result./16; %for Tsukuba
result = result./8; %for Venus
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
err = abs(gt - result);
pixnum = 0;
for i = 1: x
    for j = 1 : y
     %   if (nonocclusion(i,j) ~= 0)
           if (gt(i,j) ~= 0)
              pixnum = pixnum + 1;
              if (err(i,j) > 1) %for err map results replace with errresult(i,j) < 255
                  r = r + 1; % Wrong pixels
              end
            end
     %   end
    end
end
for m = 1 : x
    for n = 1 : y
    %    if (nonocclusion(m,n) ~= 0)
            if (gt(m,n) ~= 0)
                if (err(m,n) > 1)
                    errmap(m,n) = 255;
                end
            end
    %    end
    end
end
percent = (r ./ pixnum) * 100;
a = max(max(gt)); % Divider factor for visiabling gt
b = max(max(result)); % Divider factor for visiabling result
imshow(gt./a)
figure
imshow(result./b)
figure
imshow(errmap)
            

