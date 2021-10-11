function [dL,dR]=LBP_alpha_Brief_Mask(l,r,i,j,nbit,ws,alpha,selec1,selec2,selec3)

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
  
DL=[DL1(selec1) DL2(selec2) DL3(selec3)];
DR=[DR1(selec1) DR2(selec2) DR3(selec3)];
dL=DL>l(i,j);
dR=DR>r(i,j);
        
        