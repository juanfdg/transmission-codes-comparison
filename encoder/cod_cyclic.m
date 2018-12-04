function codeword = cod_cyclic(infoword, n, k)
    [g, d] = generator_poly(n, k);
    G = generator_matrix(g, n, k);
    