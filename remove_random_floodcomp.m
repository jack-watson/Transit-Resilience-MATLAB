function G_s = remove_random_floodcomp(G, to_remove_fl)


G_s = cell(1, length(to_remove_fl));
G_prime = G;
for i = 1:length(G_s)
    if i == 1
         rmidx = randi([1 height(G_prime.Nodes)], [length(to_remove_fl{i}), 1]);
    else
        [~,~,ib] = setxor(prev_rem, to_remove_fl{i});
        if isempty(ib)
            G_s{i} = G_prime;
            continue
        else
            rmidx = randi([1 height(G_prime.Nodes)], [length(ib), 1]);
        end
    end
    G_prime = rmnode(G_prime, G_prime.Nodes.Name(rmidx));
    prev_rem = to_remove_fl{i};
    G_s{i} = G_prime;
end

end