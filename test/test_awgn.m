in = zeros(4,2);
in(1,:) = [0,-1];
in(2,:) = [0,1];
in(3,:) = [1,0];
in(4,:) = [-1,0];

out = awgn(in,0.1);

scatter(out(:,1), out(:,2), [], 'blue', 'filled');
hold on;
scatter(in(:,1), in(:,2), [], 'red', 'filled');
