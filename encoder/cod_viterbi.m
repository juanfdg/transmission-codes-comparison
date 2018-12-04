function v = cod_viterbi(u, m)
    g1 = [];
    g2 = [];
    g3 = [];

    if m == 3
        g1 = [1,0,1,1];
        g2 = [1,1,0,1];
        g3 = [1,1,1,1];
    end

    if m == 4
        g1 = [1,0,1,0,1];
        g2 = [1,1,0,1,1];
        g3 = [1,1,1,1,1];
    end

    if m == 6
        g1 = [1,0,0,1,1,1,1];
        g2 = [1,0,1,0,1,1,1];
        g3 = [1,1,0,1,1,0,1];
    end

    G = [g1;g2;g3];
    state = zeros(1,m);
    v = zeros(1,3*length(u));

    for (idx = 1:length(u))
        bit = u(idx);
        v((idx-1)*3+1:idx*3) =  mod(G*[bit, state]',2)';
        state = [bit, state(1:length(state)-1)];
    end
end