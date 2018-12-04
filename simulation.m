snr_db_array = 0:1:20;
snr_array = 10.^(snr_db_array./20);
p_array = @(rate) arrayfun(@(snr) qfunc(sqrt(2*rate*snr)), snr_array);
nbits = 1000000;
u = randi([0,1],1,nbits);

semilogy(snr_db_array, p_array(1), 'DisplayName', 'Direto');
title("Erros percentuais de bits com diferentes SNR's")
xlabel('Ei/N0 (dBW)')
ylabel('Probabilidade de Erro de Bit')

hold on

% Codificacao de Hamming
%{
rate_hamming = 4/7;
words = reshape(u, [nbits/4,4]);
errors_hamming = zeros(size(snr_array));
v = cod_hamming(words);
parfor (idx = 1:length(snr_array), 4)
    snr = snr_array(idx);
    v_bsc = bsc(v, rate_hamming*snr);
    words_decoded = decod_hamming(v_bsc);
    error = sum(sum(words ~= words_decoded))/nbits;
    errors_hamming(idx) = error;
end

semilogy(snr_db_array, errors_hamming, 'DisplayName', 'Hamming(7,4)');
%}
%compairHamming;

% Codificacao ciclica
n_array = [10, 12, 14, 15, 16];
k_array = [6, 7, 8, 9, 9];
errors_cyclic = zeros(5,length(snr_array));
rates_cyclic = k_array./n_array;
%{
for i = 1:5
    n = n_array(i);
    k = k_array(i);
    rate_cyclic = rates_cyclic(i);
    g = generator_poly(n, k);
    
    parfor (idx = 1:length(snr_array), 4)
        fprintf('idx = %d\n', idx)
        snr = snr_array(idx);
        bsc_errors = bsc(zeros(floor(nbits/n),n), rate_cyclic*snr);
        bsc_errors_decoded = decod_cyclic(bsc_errors, g, n, k);
        error = sum(sum(bsc_errors ~= bsc_errors_decoded))/nbits;
        errors_cyclic(i, idx) = error;
    end
end

semilogy(snr_db_array, errors_cyclic(1,:), 'DisplayName', 'Ciclico 1');
semilogy(snr_db_array, errors_cyclic(2,:), 'DisplayName', 'Ciclico 2');
semilogy(snr_db_array, errors_cyclic(3,:), 'DisplayName', 'Ciclico 3');
semilogy(snr_db_array, errors_cyclic(4,:), 'DisplayName', 'Ciclico 4');
semilogy(snr_db_array, errors_cyclic(5,:), 'DisplayName', 'Ciclico 5');
%}

% Codificacao convolucional
%{%
error_viterbi_hamming = zeros(size(snr_array));
error_viterbi_awgn = zeros(size(snr_array));
error_viterbi_euclidian = zeros(size(snr_array));

rate_conv = 1/3;

u = randi([0,1],1,100000);

m_array = [3,4,6];

for m = m_array
    fprintf('m = %d\n', m)
    v = cod_viterbi(u,m);
    v_bpsk = mod_bpsk(v);
    parfor (idx_p = 1:length(snr_array), 4)
        fprintf('idx_p = %d\n', idx_p)
        snr = rate_conv*snr_array(idx_p);
        
        v_bsc = bsc(v,snr);
        v_awgn = awgn(v_bpsk,snr);
        
        u_decod_hamming = decod_viterbi(v_bsc, m, 'hamming');
        u_decod_awgn = decod_viterbi(v_bsc, m, 'bpsk-awgn', snr);
        u_decod_euclidian = decod_viterbi(v_awgn, m, 'bpsk-euclidian');
        
        errors_viterbi_hamming = u ~= u_decod_hamming;
        errors_viterbi_awgn = u ~= u_decod_awgn;
        errors_viterbi_euclidian = u ~= u_decod_euclidian;
        
        error_viterbi_hamming(idx_p) = sum(errors_viterbi_hamming)/length(u);
        error_viterbi_awgn(idx_p) = sum(errors_viterbi_awgn)/length(u);
        error_viterbi_euclidian(idx_p) = sum(errors_viterbi_euclidian)/length(u);
    end
    leg = sprintf("Convolucional - Distancia de Hamming (%d estados)", m);
    semilogy(snr_db_array, error_viterbi_hamming, 'DisplayName', leg);
    leg = sprintf("Convolucional - Probabilidade BSC (%d estados)", m);
    semilogy(snr_db_array, error_viterbi_awgn, 'DisplayName', leg);
    leg = sprintf("Convolucional - Distancia Euclidiana (%d estados)", m);
    semilogy(snr_db_array, error_viterbi_euclidian, 'DisplayName', leg);
end
%}

legend show
hold off