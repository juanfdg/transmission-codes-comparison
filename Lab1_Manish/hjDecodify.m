function [infoWord] = hjDecodify(codeWord)

    [S, C, Ht, G] = generate_code();
 
    k = 15;
    n = 8;

    sindrome = mod(codeWord*Ht, 2);
    dim = size(sindrome, 1); 

    aux = zeros(dim, k);
    x = 1;
    for i = 1:dim
        s = sindrome(i,:);
        
        for j = 1:128
            if isequal(s, S(j,:))
                x = j;
                break;
            end
        end

        aux(i,:) = mod(codeWord(i,:) + C(x,:), 2);
    end

    infoWord = zeros(dim, n);
    for i = 1:n
        infoWord(:,i) = aux(:,i);    
    end

end