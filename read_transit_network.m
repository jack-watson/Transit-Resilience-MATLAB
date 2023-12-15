function G = read_transit_network(fname, sheetname)

if nargin > 1
    impOpts = detectImportOptions(fname, 'Sheet', sheetname);
else
    impOpts = detectImportOptions(fname);
end

impOpts = setvartype(impOpts, 'Line', 'string');  % or 'char' if you prefer

if nargin > 1 % read excel sheet if supplied with a sheet name
    %XL = readtable(fname, 'Sheet', sheetname);
    XL = readtable(fname, impOpts, 'Sheet', sheetname);
else % otherwise don't
    XL = readtable(fname, impOpts);
    %XL = readtable(fname);
end

nodeList = XL.Index; % numeric index of each node from sheet
adjList  = XL.Adj; % list of adjacent nodes corresponding to nodeList
Nv = length(nodeList); % number/count of nodes/vertices
node_names = XL.Name; % station names for each node

if length(XL.Name) ~= length(unique(XL.Name)) % Force unique name strings
    name_idx = num2cell(1:length(XL.Name));
    name_idx = cellfun(@(x) num2str(x), name_idx, 'UniformOutput', false);
    node_names = cellfun(@(x,y) [x '_ ' y], node_names, name_idx', 'UniformOutput', false);
end

% Create graph object with Nv nodes and no edges
G  = graph(zeros(Nv), node_names); % station names correspond to each node

% Iteratively add edges/links to graph according to adjList
rExp = '\s';
rFun = @(x) regexp(x, rExp, 'split');
for iv = 1:Nv
    ia = adjList{iv};
    ieStr = rFun(ia);
    for je = 1:length(ieStr)
        e = str2double(ieStr{je});
        eidx = find(nodeList == e);
        if ~isempty(eidx) && ~isnan(eidx) && (edgecount(G,iv,eidx) == 0)
            G = addedge(G, iv, eidx, 1);
        end
    end
end

varCheck = @(x,y) ismember(y, x.Properties.VariableNames);

G.Nodes.index  = XL.Index;
G.Nodes.lat    = XL.Lat;
G.Nodes.lon    = XL.Lon;
if varCheck(XL, 'Elev_ft')
    G.Nodes.el_plt = XL.Elev_ft;
end
if varCheck(XL, 'Elev_m_10m_DEM')
    G.Nodes.el_trk = XL.Elev_m_10m_DEM;
end
if varCheck(XL, 'Line')
    G.Nodes.line   = XL.Line;
end
if varCheck(XL, 'System')
    G.Nodes.system = XL.System;
end
if varCheck(XL, 'Scale')
    G.Nodes.scale = XL.Scale;
end
if varCheck(XL, 'Bridge')
    G.Nodes.bridge = XL.Bridge;
end
if varCheck(XL, 'Bridge_sys')
    G.Nodes.bridge_sys = XL.Bridge_sys;
end
if varCheck(XL, 'Scale')
    G.Nodes.scale = XL.Scale;
end
%G.Nodes.branch = XL.Branch;



G.Nodes.line(ismissing(G.Nodes.line)) = deal(' ');

end

%G.Nodes(cellfun(@(x) strcmp(x, ''))
% plot(G, 'XData', XL.Lon, 'YData', XL.Lat)
