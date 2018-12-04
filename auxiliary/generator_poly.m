function [g, maximum_distance] = generator_poly(n, k)

poly = cyclpoly(n, k, 'all');

maximum_distance = 0;

for j = 1:size(poly,1)
    G = generator_matrix(poly(j, :), n, k);
    words = generator_words(G);
    d = minimum_distance(words);
    if d > maximum_distance
        maximum_distance = d;
        g = poly(j, :);
    end
end

end