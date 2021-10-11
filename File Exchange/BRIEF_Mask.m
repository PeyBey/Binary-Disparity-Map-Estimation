function [dL,dR]=BRIEF_Mask(imgL,imgR,i,j)
ws=7;
nbit=8;
maskL=imgL(i-3:i+3,j-3:j+3);
maskR=imgR(i-3:i+3,j-3:j+3);
for count=1:nbit
a1=randi(ws);
a2=randi(ws);
% row1=floor(ws*ws/a1);
% col1=rem(ws*ws,a1);
% 
% row2=floor(ws*ws/a2);
% col2=rem(ws*ws,a2);
a3=randi(ws);
a4=randi(ws);
dL(count)=maskL(a1,a2)>maskL(a3,a4);
dR(count)=maskR(a1,a2)>maskR(a3,a4);
end
