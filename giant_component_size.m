function N = giant_component_size(G)

% INPUT:
%       G: network (graph object)
% OUTPUT:
%       N: number of nodes in giant component


if isempty(G)
    N = 0;
    return
end

[~,binsize] = conncomp(G); % bin all connected components
N = max(binsize);
% lgestIdx = find(max(binsize));
% binIdx = find(bin == lgestIdx);
% %binIdx = binsize(bin) == max(binsize); % get index of largest connected component
% LC = subgraph(G, binIdx); % isolate subgraph LC, the largest connected component in G
% N = height(LC.Nodes(:,:)); % number of nodes in giant component LC

if isempty(N)
    N = 0;
end

end