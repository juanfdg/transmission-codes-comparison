function s = syndrom(error, gen_poly)
    g_inv = fliplr(gen_poly);
    e_inv = fliplr(error);
    [q, r] = deconv(e_inv, g_inv);
    r = fliplr(r);
    r = r(1:(size(gen_poly, 2)-1));
    r = mod(r, 2);
    s = r;
end