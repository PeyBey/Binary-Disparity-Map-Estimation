function [dL,dR]=LBP_alpha_Mask1(l,r,i,j,nbit,ws,alpha)

maskL=l(i-ws/2+1:i+ws/2,j-ws/2:j+ws/2);
maskR=r(i-ws/2+1:i+ws/2,j-ws/2:j+ws/2);
[n1,n2]=size(maskL);

DL1=maskL(n1/2,:);
DR1=maskR(n1/2,:);


cnt=0;
for u1=1:n1
    cnt=cnt+1;
    for u2=1:n2
        if u1==u2
            DL2(cnt)=maskL(u1,u2);
            DR2(cnt)=maskR(u1,u2);
        end
    end
end

cnt=0;
for u1=n1:-1:1
    cnt=cnt+1;
    for u2=1:n2
        if u1==u2
            DL3(cnt)=maskL(u1,u2);
            DR3(cnt)=maskR(u1,u2);
        end
    end
end 
  
DL=[DL1(1:nbit) DL2(1:nbit) DL3(1:nbit)];
DR=[DR1(1:nbit) DR2(1:nbit) DR3(1:nbit)];
dL=DL>l(i,j);
dR=DR>r(i,j);
        
        