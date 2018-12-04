function final = minimum_distance(words)
    s = size(words);
    final = s(2);
    
    for i = 1:s(1)
        current = sum(words(i,:));
        if current < final
            final = current;
        end
    end
end
