function [out]=standard_array()
n=23;
k=12;
r=n-k;
msg=de2bi(0:2^k-1,'left-msb');
pol=[1 0 1 0 1 1 1 0 0 0 1 1];%the coefficiences of the polynomials of the golay code
[h,g]=cyclgen(n,pol,'system');
trt = syndtable(h); % Produce decoding table(2^11,23),error pattern
cdword_matrix=zeros(2^k,n);
  for i=1:2^k
      box=zeros(1,k);
      box=msg(i,:);
      cdword_matrix(i,:)=rem(box*g,2);
  end
  %construct standard array
  st_ar = cell(2^r,2^k);
 
  for i=1:2^k
      for j=1:2^r
          new_temp=cdword_matrix(i,:)+trt(j,:);
          st_ar{j,i}=new_temp;
      end
  end
  out=st_ar;
