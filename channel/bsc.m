function v_bsc = bsc(v, gamma)
    p = qfunc(sqrt(2*gamma));
    random = rand(size(v));
    
    error = random <= p;
    
    v_bsc = mod(v+error, 2);
end