function [out]=syndrome_table()
n=23;
k=12;
r=n-k;
pol=[1 0 1 0 1 1 1 0 0 0 1 1];%the coefficiences of the polynomials of the golay code
[h,g]=cyclgen(n,pol);%generate the parity check matrix and generator matrix
trt = syndtable(h); % Produce decoding table(2^11,23),error pattern
syn_table=cell(2^r);
for syn=1:2^r
      temp_trt=trt(syn,:);
      synd_pat=rem(h*transpose(temp_trt),2);
      syn_table{syn}=synd_pat;
end
  out=syn_table;