% Probabilidade do canal
p = p_array(4/7);
pb_hamming = zeros(1,length(p));

for i = 1:length(p)
    pb_hamming(i) = hammingSimulation(sentWord, codifiedWord, p(i));
end

%semilogy(snr_db_array, pb_hj, 'DisplayName', 'Codificacao Personalizada');