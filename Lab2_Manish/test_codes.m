n = [10 12 14 15 16];
k = [6 7 8 9 9];

hold on

txt = cell(5,1);

for i = 1:5
    [g, d] = generator_poly(n(i), k(i))
    p = [0.5 0.2 0.1 0.05 0.02 0.01 0.005 0.002 0.001 0.0005 0.0002 0.0001 0.00005 0.00002 0.00001];
    samples = fix(1000000/n(i));
    pb = zeros(1, length(p));
    n_now = n(i);
    k_now = k(i);
    parfor (j = 1:length(p), 4)
        x = rand(samples, n_now);
        errors = x < p(j);
        dec_errors = decodify1bit(errors, g, n_now, k_now);
        pb(j) = mean(mean(mod(dec_errors + errors, 2)));
    end
    
    plot(p, pb);
    txt{i}= sprintf('código (%i, %i)', n(i), k(i));
end

legend(txt)

plot(p, p);
title("Erros percentuais de bits com diferentes p's")
xlabel('p')
ylabel('Erro')
set(gca, 'Xdir', 'reverse');


