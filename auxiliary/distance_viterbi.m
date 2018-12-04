function distance = distance_viterbi(v1, v2, method, gamma)
    if nargin < 4
        gamma = -1;
    end
    
    %disp(method)
    if strcmp(method, 'hamming')
        %disp('hamming')
        distance = sum(mod(v1+v2,2));
    elseif strcmp(method, 'bpsk-awgn')
        %disp('bpsk-awgn')
        p = qfunc(sqrt(2*gamma));
        nequals = sum(v1 == v2);
        ndiff = sum(v1 ~= v2);
        distance = -(nequals*log(1-p) + ndiff*log(p));
    elseif strcmp(method, 'bpsk-euclidian')
        %disp('euclidian')
        v1 = mod_bpsk(v1);
        distance = norm(v2-v1);
    end
end