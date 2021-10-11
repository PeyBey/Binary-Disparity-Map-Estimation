clc
close all
clear
w = input('Window Size = ') ;
dmax = input('Dmax = ') ;
imgl1 = imread('F:\Proj\Project\Bagheri Image OpenCV\New Code 1\Bagheri Codes 1\Teddy_left.png');
imgr1 = imread('F:\Proj\Project\Bagheri Image OpenCV\New Code 1\Bagheri Codes 1\Teddy_right.png');
imgc = imread('F:\Proj\Project\Bagheri Image OpenCV\New Code 1\Bagheri Codes 1\Teddy_left_groundtruth.png');
%imgc = rgb2gray(imgc);
imgc = imgc./4;
imgc = double(imgc);
erm = 0;
cnt = 0;
imgl = double(rgb2gray(imgl1)) ;
imshow(imgl);
imgr = double(rgb2gray(imgr1)) ;
[x,y] = size(imgl);
wx=(w-1)/2; wy=(w-1)/2;
for i = wx+1 : x-wx
%      if ((i-wx)<1 || (i+wx)>x)
%          dispmapL(i,1:y)=0;
%          continue;
%      end
    for j = wy+1 : y-wy
       


%                     if ((j-wy)<1 || (j+wy)>y)
%                         dispmapL(i,j)=0;
%                         continue;
%                     end
                    
%                     if (j <= 40)
                    for d=0:dmax
                        if (j-d-wy <1)
                            SAD(d+1)=100000;
                        else
                            SAD(d+1) = sum(sum(abs(imgl(i-wx : i+wx,j-wy : j+wy) - imgr(i-wx : i+wx,j-d-wy : j-d+wy))));
                   
                        end
                        if ((j+d-wy <1) || (j+d+wy > y))
                            SAD2(d+1)=100000;
                        else
                            SAD2(d+1) = sum(sum(abs(imgr(i-wx : i+wx,j-wy : j+wy) - imgl(i-wx : i+wx,j+d-wy : j+d+wy))));
                   
                        end
                    end
                    [mincost,minindex]=min(SAD);
                    dispmapL(i-wx,j-wy)=minindex-1;
                    
                    [mincost2,minindex2]=min(SAD2);
                    dispmap2(i,j)=minindex2-1;

%                         bac = j;
%                         while(dispmap(i,j) ~= dispmap2(i,j))
%                             j = j - 1;
%                         end
%                         
%                         tot(i,bac) = min(dispmap(i,j),dispmap2(i,j));
%                         j = bac;
                    
               
                    
    end
end

% cax = zeros(wx,y-wy);
% cay = zeros(x,wy);
% tot = cat(1,tot,cax);
% tot = cat(2,tot,cay);
% dispmap = cat(1,dispmap,cax);
% dispmap = cat(2,dispmap,cay);
dispmapL = imresize(dispmapL,[x y]);
dispmapL = uint8(dispmapL);
dispmap2 = imresize(dispmap2,[x y]);
dispmap2 = uint8(dispmap2);
imgc = imresize(imgc,[x y]);
%imgc = uint8(imgc / 16);
imgc = uint8(imgc/4);
imshow((dispmapL));
figure;
imshow((imgc));
figure;
imshow((dispmap2));
% figure;
% imshow(tot);
% figure;
% imshow(imgc);

for i2 = 1 : x
    for j2 = 1 : y
                        if((j2-minindex-1) > 0)
                            if (dispmapL(i2,j2) == dispmap2(i2,j2-minindex-1))
                        tot(i2,j2) = dispmapL(i2,j2);
                            else
                         tot(i2,j2) = 255;
%                                                         bac = j2;
%                             
%                         while((dispmapL(i2,j2) ~= dispmap2(i2,j2-minindex-1)) && (j2-minindex-1 > 1))
%                             if((j2-minindex-1) > 1)
%                             j2 = j2 - 1;
%                         end
%                             end
%                         tot(i,bac) = dispmapL(i2,j2);
%                         j2 = bac;
                                
                            end
                        end
        
    end
end
tot = uint8(tot);
erm = imgc - tot;
for i3 = 1 : x
    for j3 = 1 : y
if (abs(erm(i3,j3)) > 1)
   cnt = cnt + 1;
end
    end
end
figure;
imshow(tot);
% cnt = nnz(erm);
ert = cnt / (x * y)