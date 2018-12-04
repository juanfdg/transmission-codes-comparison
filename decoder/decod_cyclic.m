function dec_errors = decod_cyclic(errors, gen_poly, n, k)
    % Calculate minimum error hamming pound associated to each syndrom
    total_errors = de2bi(0:2^n-1);
    total_syndroms = de2bi(0:2^(n-k)-1);
    total_syndroms = [total_syndroms, zeros(2^(n-k),1)];
    for i = 1:size(total_errors, 1)
        pound = sum(total_errors(i,:));
        s = syndrom(total_errors(i,:), gen_poly);
        idx = bi2de(s) + 1;
        if(total_syndroms(idx, (n-k)+1) > pound || total_syndroms(idx, (n-k)+1) == 0)
            total_syndroms(idx, (n-k)+1) = pound;
        end
    end

    % Syndrom associated to first bit error
    first_bit_errors = de2bi(0:(2^(n-1)-1));
    first_bit_errors = [ones(size(first_bit_errors, 1), 1), first_bit_errors];
    first_bit_syndroms = zeros(1, n-k);
    for i = 1:size(first_bit_errors, 1)      
        pound = sum(first_bit_errors(i,:));
        s = syndrom(first_bit_errors(i,:), gen_poly);
        if ~ismember(s, first_bit_syndroms, 'rows')
            idx = bi2de(s) + 1;
            if total_syndroms(idx, (n-k)+1) == pound
                first_bit_syndroms = [first_bit_syndroms; s];
            end
        end
    end
    first_bit_syndroms = first_bit_syndroms(2:end, 1:(n-k));
        
    % Matrix to store the decodified errors
    dec_errors = zeros(size(errors,1), n);
    
    % Decodifying algorithm
    for i = 1:size(errors, 1)
        e = errors(i,:);
        s = syndrom(e, gen_poly);
        turns = 0;
        
        if isequal(s, zeros(1, n-k))
            failed = true;
        else
            ocurrent_syndroms = s;
            failed = false;
            while ~isequal(s, zeros(1, n-k))
                if ismember(s, first_bit_syndroms, 'rows')
                    dec_errors(i, 1) = 1;
                    e(1) = mod(e(1)+1, 2);
                    s = syndrom(e, gen_poly);
                    %if ismember(s, ocurrent_syndroms, 'rows')
                    %    failed = true;
                    %   break
                    %end
                    ocurrent_syndroms = [ocurrent_syndroms; s];
                else
                    dec_errors(i, :) = circshift(dec_errors(i, :), 1);
                    e = circshift(e, 1);
                    turns = turns + 1;
                    s = syndrom(e, gen_poly);
                    if ismember(s, ocurrent_syndroms, 'rows')
                        failed = true;
                        break
                    end
                end
            end
        end
        
        if failed
            dec_errors(i,:) = zeros(1,n);
        else
            dec_errors(i, :) = circshift(dec_errors(i, :), -turns);
        end
    end
end