function words = generator_words(G)
    dim = size(G);
    U = dec2bin(0:(2^dim(1)-1)) - '0';
    words = U * G;
    words = mod(words, 2);
    words = words(2:end, :);
end