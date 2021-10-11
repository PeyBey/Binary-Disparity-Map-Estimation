function [dL,dR]=LBP_alpha_Mask(l,r,i,j,nbit,ws,alpha)

maskL=l(i-ws/2:i+ws/2,j-ws/2:j+ws/2);
maskR=r(i-ws/2:i+ws/2,j-ws/2:j+ws/2);
[n1,n2]=size(maskL);
if alpha==0
    DL=maskL(n1/2,:);
    DR=maskR(n1/2,:);
else
    if alpha==135
        cnt=0;
        for u1=1:n1
            cnt=cnt+1;
            for u2=1:n2
                if u1==u2
                    DL(cnt)=maskL(u1,u2);
                    DR(cnt)=maskR(u1,u2);
                end
            end
        end
    else
        cnt=0;
       for u1=n1:-1:1
            cnt=cnt+1;
            for u2=1:n2
                if u1==u2
                    DL(cnt)=maskL(u1,u2);
                    DR(cnt)=maskR(u1,u2);
                end
            end
        end 
    end
end
dL=DL>l(i,j);
dR=DR>r(i,j);
        
        