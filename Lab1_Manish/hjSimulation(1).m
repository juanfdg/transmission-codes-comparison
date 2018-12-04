function [error] = hjSimulation(sentWord, codifiedWord, p)
%     codifiedWord = hammingCodify(sentWord);
    transmitedWord = transmit(codifiedWord, p);
    decodifiedWord = hjDecodify(transmitedWord);
    
    error = mean(mean(mod(decodifiedWord + sentWord, 2)), 2);
end 
   