% function [out]=GOLAY_decoder(recv_data)
n=23;
k=12;
r=n-k;
recv_data=ones(1,n);
g=[1 0 1 0 1 1 1 0 0 0 1 1];%the coefficiences of the polynomials of the golay code
new_data=recv_data;
v1=zeros(1,n-1);
v=[1,v1];
[quo,syndrome1]=deconv(recv_data,g);
syndrome=mod(syndrome1,2);
syntable=zeros(n,r);
counter=0;
invert_index=1;
err_pat=zeros(1,n);
for i=1:n
    new_data=bitshift(recv_data,counter);
    syndrome=deconv(new_data,g);
    syndrome=mod(syndrome,2);
    syntable(i,:)=syndrome;
    counter=counter+1;
end


    
    
