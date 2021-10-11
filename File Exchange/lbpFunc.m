function [dispMap1,gr,E]=lbpFunc(l,r,ws,disparity,filt,filtWindow,GR,scale)
[e1,e2]=size(l);


for i=ws/2:e1-ws/2
    for j=ws/2:e2-ws/2
        pixelL=l(i,j);
        dL=LBPmask(pixelL,l,i,j);
        LeftDescriptor(i,j).Binary=dL;
        LeftDescriptor(i,j).Decimal=[];
        pixelR=r(i,j);
        dR=LBPmask(pixelR,r,i,j);
        RightDescriptor(i,j).Binary=dR;
        RightDescriptor(i,j).Decimal=[];
    end
end
for i=ws/2:e1-ws/2
    for j=ws/2:e2-ws/2-disparity
        for k=disparity:-1:1
%             J(k)=abs(LeftDescriptor(i,j+k).Decimal-RightDescriptor(i,j).Decimal);
            J(k,:)=xor(LeftDescriptor(i,j+k).Binary,RightDescriptor(i,j).Binary);
            NNZ(k)=nnz(J(k,:));
        end
%         nnz(J)
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