function [transmitedWord] = transmit(codeWord, p)
    sz = size(codeWord);
    error = rand(sz);
    x = error < p;
    transmitedWord = mod(codeWord + x, 2);
end
