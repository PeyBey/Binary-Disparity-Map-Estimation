function [dispMap1,gr,E]=lbpAlpha_BRIEF_Func(l,r,ws,disparity,filt,filtWindow,nbit,GR,scale)
[e1,e2]=size(l);
a1=randi(ws-1,1,nbit);
a2=randi(ws-1,1,nbit);
a3=randi(ws-1,1,nbit);
a4=randi(ws-1,1,nbit);
alpha=45;
selector1=randi(nbit,1,ws);
selector2=randi(nbit,1,floor(sqrt(2*(ws/2)^2)));
selector3=randi(nbit,1,floor(sqrt(2*(ws/2)^2)));
for i=ws/2+1:e1-ws/2-1
    for j=ws/2+1:e2-ws/2-1
        pixelL=l(i,j);
        [dL,dR]=LBP_alpha_Brief_Mask(l,r,i,j,nbit,ws,alpha,selector1,selector2,selector3);
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