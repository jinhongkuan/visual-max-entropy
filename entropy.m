function out = entropy(range, conv_multiplier, variance)
granularity = 10;
domain = 1/granularity:1/granularity:1;
out = 0;
for i = 1:3
    P = zeros(1, granularity);
    for y = 1:size(range,1)
        for x = 1:size(range, 2)
            d = makedist('normal','mu',range(y,x,i), 'sigma', variance);
            t = pdf(d, domain); 
            P = P + conv_multiplier(y,x) * t;
        end
    end
    P = P ./ granularity;
    out = out + sum(-P .* log(P));
end
end

