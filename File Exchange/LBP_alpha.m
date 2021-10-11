clc
clear all;
close all;
l0=imread('left1.png');
r0=imread('right1.png');
l=rgb2gray(l0);
r=rgb2gray(r0);
% l=l0(:,:,3);
% r=r0(:,:,3);
[e1,e2]=size(l);
ws=32;
disparity=73;
nbit=32;
d=zeros(1,nbit);
% load('CensusSparseL.mat')
% load('CensusSparseR.mat')
a1=randi(ws-1,1,nbit);
a2=randi(ws-1,1,nbit);
a3=randi(ws-1,1,nbit);
a4=randi(ws-1,1,nbit);
alpha=45;
for i=ws/2+1:e1-ws/2-1
    for j=ws/2+1:e2-ws/2-1
        pixelL=l(i,j);
        [dL,dR]=LBP_alpha_Mask1(l,r,i,j,nbit,ws,alpha);
        LeftDescriptor(i,j).Binary=dL;
        LeftDescriptor(i,j).Decimal=bi2de(dL);
        RightDescriptor(i,j).Binary=dR;
        RightDescriptor(i,j).Decimal=bi2de(dR);
    end
end
for i=ws/2+1:e1-ws/2-1
    for j=ws/2+1:e2-ws/2-disparity-1
        for k=disparity:-1:1
            J(k)=abs(LeftDescriptor(i,j+k).Decimal-RightDescriptor(i,j).Decimal);
        end
        [q1,q2]=min(J);
        dispMap(i,j)=q2;
    end
end
th=15;
dispMap1= medfilt2(dispMap,[16 16]);
imshow(single(dispMap1),[0 disparity])
% Z=imabsdiff(dispMap,r(1:size(dispMap,1),1:size(dispMap,2)));
% acc=Z>th;
% Acc=(e1*e2-nnz(acc))/(e1*e2)
