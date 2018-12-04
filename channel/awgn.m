function out = awgn(in, snr)
    out = arrayfun(@(x) x + normrnd(0, sqrt(1/2/snr)), in);
end

