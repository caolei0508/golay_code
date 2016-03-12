close all
clear all
n=23;%length of the codewords
k=12;%length of the message
r=n-k;
snr=2;%signal to noise ratio in dB 
pol=[1 0 1 0 1 1 1 0 0 0 1 1];%the coefficiences of the polynomials of the golay code
[h,g]=cyclgen(n,pol);%generate the parity check matrix and generator matrix
% stan_array=standard_array();
syn_table=syndrome_table1();

    ber_counter=0;%the counter of the error number
    ndata=0;%the number of bits transmitted
    ber_lim=100;%the limit of the error number
    while ber_counter<ber_lim
        ndata=ndata+1;
        source=(rand(1,k))>0.5;
        enco_data=golay_encoder(source);
        %BPSK modulation
        mod_data=enco_data.*2-1;
        %**********************************
        %genenrate AWGN channel and noise
        %*******************************************************
        N0=10^(-snr/10)*2;
        sigma=sqrt(N0/2);
        rand_noise=randn(1,n);
        noise=sigma*rand_noise;
%         spow=sum(mod_data.*mod_data)/n;
% 	    attn=0.5*spow*10.^(-snr(i)/10);
% 	    attn=sqrt(attn);
%         noise=randn(1,length(mod_data)).*attn;   % Add White Gaussian Noise (AWGN)
        channel_data=mod_data+noise;
        %**********************************************
        %BPSK demodulation
        %*************************************************
        demo_data=channel_data>0;
        %****************************************************
        %GOlay decoding process
        %****************************************************
        syndrome=rem(h*transpose(demo_data),2);
       index=1;
        while syndrome~=syn_table{index,1}
            index=index+1;
        end
        deco_data=demo_data+syn_table{index,2};
        deco_data1=deco_data(1,n-k+1:n);
        temp_error=sum(abs(source-deco_data1));
        ber_counter=ber_counter+temp_error;
%         for j=1:n
%             if deco_data(j)~= enco_data(j)
%                 ber_counter(i)=ber_counter(i)+1;
%             end
%         end
    end
    ber=ber_counter/(ndata*k);

%theortetical BPSK error rate
%************************************
% EbN0_the=2
% for i=1:length(EbN0_the)
%     SNR=2*10^(EbN0_the(i)/10);
%     ber_the(i)=0.5*erfc(sqrt(SNR));
%     
% end
% semilogy(snr,ber,'o');
% hold on;
% semilogy(EbN0_the,ber_the,'*');
% title('\bf BER performance of Golay coding and BPSK modulation system');
% xlabel('\fontsize{10} \bf Eb/N0');ylabel('\fontsize{10} \bf BER');
% legend('BER-EbNo with Golay coding','theoretical BER-EbNo curve');

    
