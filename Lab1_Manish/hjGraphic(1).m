% Probabilidade do canal
p = [0.5 0.2 0.1 0.05 0.02 0.01 0.005 0.002 0.001 0.0005 0.0002 0.0001 0.00005 0.00002 0.00001];% 0.000005 0.000002];
pb_hj = zeros(1,length(p));

for i = 1:length(p)
    pb_hj(i) = hjSimulation(sentWord, codifiedWord, p(i));
end

loglog(p, pb_hj)