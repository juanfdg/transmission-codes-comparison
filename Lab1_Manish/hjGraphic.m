% Probabilidade do canal
p = p_array(5/8);
pb_hj = zeros(1,length(p));

for i = 1:length(p)
    pb_hj(i) = hjSimulation(sentWord, codifiedWord, p(i));
end

%semilogy(snr_db_array, pb_hj, 'DisplayName', 'Codificacao Personalizada');