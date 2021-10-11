function dispMap1=censparFunc(l,r,ws,disparity,filt,filtWindow)
[e1,e2]=size(l);
for i=ws/2:e1-ws/2
    for j=ws/2:e2-ws/2
        pixelL=l(i,j);
        dL=LBPmask(pixelL,l,i,j);
        LeftDescriptor(i,j).Binary=dL;
        LeftDescriptor(i,j).Decimal=bi2de(dL);
        pixelR=r(i,j);
        dR=LBPmask(pixelR,r,i,j);
        RightDescriptor(i,j).Binary=dR;
        RightDescriptor(i,j).Decimal=bi2de(dR);
    end
end
for i=ws/2:e1-ws/2
    for j=ws/2:e2-ws/2-disparity
        for k=disparity:-1:1
            J(k)=abs(LeftDescriptor(i,j+k).Decimal-RightDescriptor(i,j).Decimal);
        end
        [q1,q2]=min(J);
        dispMap(i,j)=q2;
    end
end
if filt
 dispMap1= medfilt2(dispMap,[filtWindow filtWindow]);
else
    dispMap1=dispMap;
end