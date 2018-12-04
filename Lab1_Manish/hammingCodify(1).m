function [codeWord] = hammingCodify(infoWord)
    G = [1 0 0 0 1 1 1;
         0 1 0 0 1 0 1;
         0 0 1 0 1 1 0;
         0 0 0 1 0 1 1];
    codeWord = mod(infoWord*G, 2);
end

