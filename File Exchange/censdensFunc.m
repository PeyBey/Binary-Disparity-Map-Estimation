function [dispMap1,gr,E]=censdensFunc(l,r,ws,disparity,filt,filtWindow,GR,scale)
[e1,e2]=size(l);
for i=ws/2+1:e1-ws/2
    for j=ws/2+1:e2-ws/2
        pixelL=l(i,j);
        dL=CENSUSdense_Mask(pixelL,l,i,j,ws);
        LeftDescriptor(i,j).Binary=dL;
        LeftDescriptor(i,j).Decimal=[];
        pixelR=r(i,j);
        dR=CENSUSdense_Mask(pixelR,r,i,j,ws);
        RightDescriptor(i,j).Binary=dR;
        RightDescriptor(i,j).Decimal=[];
    end
end
for i=ws/2+1:e1-ws/2
    for j=ws/2+1:e2-ws/2-disparity
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