function [infoWord] = hammingDecodify(codeWord)

Ht = [  1 1 1; 
        1 0 1;
        1 1 0;
        0 1 1;
        1 0 0;
        0 1 0;
        0 0 1];

sindrome = mod(codeWord*Ht, 2);
dim = size(sindrome, 1); 

aux = zeros(dim, 7);
e = zeros(1, 7);
for i = 1:dim
    s = sindrome(i,:);
    for k = 1:7
        e(k) = isequal(s, Ht(k,:));
    end
    aux(i,:) = mod(codeWord(i,:) + e, 2);
end

infoWord = zeros(dim, 4);
for i = 1:4
    infoWord(:,i) = aux(:,i);    
end


end