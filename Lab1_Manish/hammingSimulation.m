function [error] = hammingSimulation(sentWord, codifiedWord, p)
%     codifiedWord = hammingCodify(sentWord);
    transmitedWord = transmit(codifiedWord, p);
    decodifiedWord = hammingDecodify(transmitedWord);
    
    error = mean(mean(mod(decodifiedWord + sentWord, 2)));
end 
   