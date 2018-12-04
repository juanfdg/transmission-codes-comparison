function G = generator_matrix(gen_poly, n, k)
    s = size(gen_poly, 2);
    
    % find generator matrix (k x n)
    G = zeros(k, n);
    G(1, 1:s) = gen_poly;
    
    for i = 2:k
        G(i, i:i+s-1) = gen_poly;
    end
end