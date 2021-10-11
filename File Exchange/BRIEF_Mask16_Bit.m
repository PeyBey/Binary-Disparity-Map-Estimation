function [dL,dR]=BRIEF_Mask16_Bit(imgL,imgR,i,j,a1,a2,a3,a4,nbit,ws)
% ws=7;
% nbit=64;
maskL=imgL(i-ws/2:i+ws/2,j-ws/2:j+ws/2);
maskR=imgR(i-ws/2:i+ws/2,j-ws/2:j+ws/2);
% a1=randi(ws,1,nbit);
% a2=randi(ws,1,nbit);
% a3=randi(ws,1,nbit);
% a4=randi(ws,1,nbit);
for count=1:nbit

% row1=floor(ws*ws/a1);
% col1=rem(ws*ws,a1);
% 
% row2=floor(ws*ws/a2);
% col2=rem(ws*ws,a2);

dL(count)=maskL(a1(count),a2(count))>maskL(a3(count),a4(count));
dR(count)=maskR(a1(count),a2(count))>maskR(a3(count),a4(count));
end
