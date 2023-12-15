function network_geoviz(G, opts)

% Requires:
% opts.state_name | e.g.: 'Massachusetts' 
% opts.state_abbrev | e.g.: 'MA'
% opts.fig_name | e.g.: 'MBTA Urban & Commuter Rail'

if strcmp(opts.state_abbrev, 'CONUS')
    opts.state_name = 'CONUS';
end

allStates = shaperead('usastatehi.shp','UseGeoCoords',true);
if ~strcmp(opts.state_abbrev, 'CONUS')
    state = allStates(strcmp({allStates.Name},opts.state_name));
end
scheck = @(f) isfield(opts, f) && ~isempty(opts.(f));

if scheck('fig_name')
    figure('Name', opts.fig_name)
else
    figure()
end
h1 = usamap([min(G.Nodes.lat) max(G.Nodes.lat)], ...
            [min(G.Nodes.lon) max(G.Nodes.lon)]);
setm(h1,'FFaceColor','#B7E9F7')
geoshow(allStates,'FaceColor','#EFE6DC')
if ~strcmp(opts.state_abbrev, 'CONUS')
    geoshow(state,'FaceColor','#90EE90')
end
%setm(h1, 'maplatlimit', [41.5800 42.7978])
if scheck('coast_path')
    land = readgeotable(opts.coast_path);
    srland = shaperead(opts.coast_path,'UseGeoCoords',true);
    %info = shapeinfo(opts.coast_path);
    %withinBox = @(xup,xlo,yup,ylo) xup
    blim = [min(G.Nodes.lon), min(G.Nodes.lat);...
        max(G.Nodes.lon), max(G.Nodes.lat)];
    bboxes = {srland.BoundingBox};
    [latlim,lonlim] = cellfun(@(x) intersectgeoquad(blim(:,2), blim(:,1), ...
        x(:,2), x(:,1)), bboxes, 'UniformOutput', false);
    intersectTF = cellfun(@(x,y) ~isempty(x) && ~isempty(y), latlim, lonlim);
    srland_int = srland(intersectTF); clear srland
%     for i = 1:height(srland_int)
%         xdata = srland_int(i).Lon;
%         xdata = xdata(~isnan(xdata));
%         ydata = srland_int(i).Lat;
%         ydata = ydata(~isnan(ydata));
%         geoshow(srland_int(i).Lon,srland_int(i).Lat)
%         %plot(xdata,ydata,'o-'); hold on
%     end

    %geoplot(land)
    %contourfm(land)
    geoshow(h1,land)
end

pltOpts = struct; pltOpts.ax_in = h1; pltOpts.scale = true;
if scheck('nodeLabelsTF')
    pltOpts.nodeLabelsTF = opts.nodeLabelsTF;
else
    pltOpts.nodeLabelsTF = false;
end

if scheck('MarkerSize')
    pltOpts.MarkerSize = opts.MarkerSize;
end

G.Nodes.line(ismissing(G.Nodes.line)) = deal(' ');

hold on; graph_geoviz_plot(G, pltOpts)

% load coastlines
% plotm(coastlat,coastlon)
if ~strcmp(opts.state_abbrev, 'CONUS')
    h2 = axes('Position',[0.15 0.25 0.2 0.2]);
    usamap(opts.state_abbrev)
    setm(h2,'FFaceColor','w')
    plabel off
    mlabel off
    gridm off
    geoshow(allStates,'FaceColor','#EDEDED')
    geoshow(state,'FaceColor','#90EE90')
end

end