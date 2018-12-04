function v_bsc = bsc(v, snr)
    p = qfunc(sqrt(2*snr));
    random = rand(size(v));
    
    error = random <= p;
    
    v_bsc = mod(v+error, 2);
end