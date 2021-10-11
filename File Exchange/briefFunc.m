function [dispMap1,gr,E]=briefFunc(l,r,ws,disparity,filt,filtWindow,nbit,GR,scale)
% nbit=32;
[e1,e2]=size(l);
a1=randi(ws-1,1,nbit);
a2=randi(ws-1,1,nbit);
a3=randi(ws-1,1,nbit);
a4=randi(ws-1,1,nbit);

for i=ws/2+1:e1-ws/2-1
    for j=ws/2+1:e2-ws/2-1
        pixelL=l(i,j);
        [dL,dR]=BRIEF_Mask16_Bit(l,r,i,j,a1,a2,a3,a4,nbit,ws);
        LeftDescriptor(i,j).Binary=dL;
        LeftDescriptor(i,j).Decimal=[];
        RightDescriptor(i,j).Binary=dR;
        RightDescriptor(i,j).Decimal=[];
    end
end
for i=ws/2+1:e1-ws/2-1
    for j=ws/2+1:e2-ws/2-disparity-1
        for k=disparity:-1:1
            J(k,:)=xor(LeftDescriptor(i,j+k).Binary,RightDescriptor(i,j).Binary);
            NNZ(k)=nnz(J(k,:));
        end
        [q1,q2]=min(NNZ);
        dispMap(i,j)=q2;
        gr(i,j)=GR(i,j);
    end
end
gr=double(gr);
if filt
 dispMap1= medfilt2(dispMap,[filtWindow filtWindow]);
else
    dispMap1=dispMap;
end
E=(gr/scale-dispMap);
bb=0;