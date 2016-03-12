function [out]=Golay_decoder2(rev_data)
n=23;
k=12;
r=n-k;
pol=[1 0 1 0 1 1 1 0 0 0 1 1];%the coefficiences of the polynomials of the golay code
[h,g]=cyclgen(n,pol);%g represents the generator matrix
                                %h represents the parity check matrix
 pty_chk=h(:,1:(n-r))
 ei=zeros(1,12);
s=rem(rev_data*h,2);
o=zeros(1,12);
u=zeros(1,24);
if (sum(s(1,:)))<=3
    u=u+[s,o]; 
else 
    for i=1:12
        c=rem(s+pty_chk(i,:),2);
        if(sum(c(1,:)))<=2
            ei(i)=ei(i)+1;
            u=u+[s+pty_chk(i,:),ei];
        end
    end   
end
if(sum(s*pty_chk))<=3
    u=u+[o,s*pty_chk];
else
    for i=1:12
        c=rem(s*pty_chk+pty_chk(i,:),2);
        if (sum(c(1,:)))<=2
            ei(i)=ei(i)+1;
            u=u+[ei,s*pty_chk+pty_chk(i,:)];
        end
    end
end
    decoder_data=mod(u+dsource,2);
   