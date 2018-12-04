function u = decod_viterbi(v, m, method, gamma)
    if nargin < 4
        gamma = -1;
    end

    n_blocks = length(v)/3 + 1;

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
    states = de2bi(0:(2^m-1));
    cost = -1*ones(2^m, n_blocks);
    cost(1,1) = 0;
    most_probable = -1*ones(2^m, n_blocks);
    for i = 1:(n_blocks-1)
        received = v((i-1)*3+1:i*3);
        
        for j = 1:size(states,1)
            state = states(j,:);
            state_cost = cost(j,i);
            
            if cost(j, i) ~= -1
                transition_cost_0 = distance_viterbi(mod(G*[0,state]',2)', received, method, gamma);
                transition_cost_1 = distance_viterbi(mod(G*[1,state]',2)', received, method, gamma);

                next_0 = bi2de([0, state(1:m-1)])+1;
                next_1 = bi2de([1, state(1:m-1)])+1;
                
                if cost(next_0,i+1) == -1 || state_cost+transition_cost_0 <= cost(next_0,i+1)
                    cost(next_0,i+1) = state_cost+transition_cost_0;
                    most_probable(next_0,i+1) = bi2de(state);
                end

                if cost(next_1,i+1) == -1 || state_cost+transition_cost_1 <= cost(next_1,i+1)
                    cost(next_1,i+1) = state_cost+transition_cost_1;
                    most_probable(next_1,i+1) = bi2de(state);
                end
            end
        end
    end
    
    min_cost = cost(1, n_blocks);
    final_state = 0;
    for i = 2:2^m
        if cost(i, n_blocks) < min_cost
            min_cost = cost(i, n_blocks);
            final_state = i-1;
        end
    end
    
    u = zeros(1, n_blocks-1);
    state = final_state;
    for i = n_blocks:-1:2
        bi = de2bi(state);
        u(i-1) = bi(1);
        state = most_probable(state+1, i); 
    end
end