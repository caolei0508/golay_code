function [out]=Golay_decoder(recv_data,std_array,syn_table)
%   recv_data:the data after demodulation
%   std_array:constructed by function standard_array()
%   syn_table:a table of structure'cell' constructed by syndrome_table()
n=23;
k=12;
r=n-k;
pol=[1 0 1 0 1 1 1 0 0 0 1 1];%the coefficiences of the polynomials of the golay code
[h,g]=cyclgen(n,pol,'system');%generate the parity check matrix and generator matrix 
synd_rev=rem(h*transpose(recv_data),2);
% synd_rev=h*transpose(recv_data)-floor((h*transpose(recv_data))./2).*2;%calculate the syndrome of the received symbol
err_ro=1;%recode the row index of the received data in the standard array
err_col=1;%recode the column index of the received data in the standard array
% find the row index of the received data in the standard array
%****************************************************************************
while synd_rev~=syn_table{err_ro}
    err_ro=err_ro+1;
end
%find the column index of the received data in the standard array
%************************************************************************
while recv_data~=std_array{err_ro,err_col}
    err_col=err_col+1;
end

% for i1=1:2^r
%     if synd_rev==syn_table{i1}
%         err_ro=i1;
%     end
% end
% for col=1:2^k
%     if recv_data==std_array(err_ro,table)
%     end
% end
%find the corresponding codewords
right_cod=std_array{1,err_col};
out=right_cod;
    
