function [plt, ax] = graph_geoviz_plot(G, opts)

if nargin == 1
    opts = struct;
end

scheck = @(f) isfield(opts, f) && ~isempty(opts.(f));

if ~scheck('ax_in')
    plt = plot(G, 'XData', G.Nodes.lon, 'YData', G.Nodes.lat);
elseif scheck('ax_in')
    ax_in = opts.ax_in;
    if scheck('scale')
        if scheck('xbounds') && scheck('ybounds')
            xbounds = opts.xbounds;
            ybounds = opts.ybounds;
            gxbounds = [min(G.Nodes.lon) max(G.Nodes.lon)];
            gybounds = [min(G.Nodes.lat) max(G.Nodes.lat)];
            dxbounds = abs(opts.xbounds - gxbounds);
            dybounds = abs(opts.ybounds - gybounds);

            xshift = dxbounds(1)*(diff(ax_in.XLim)/diff(xbounds));
            yshift = dybounds(1)*(diff(ax_in.YLim)/diff(ybounds));

            xfac = abs(diff([max(G.Nodes.lon) min(G.Nodes.lon)]))/abs(diff([xbounds(1) xbounds(2)]));
            yfac = abs(diff([max(G.Nodes.lat) min(G.Nodes.lat)]))/abs(diff([ybounds(1) ybounds(2)]));

            lonScale = rescale(G.Nodes.lon, ax_in.XLim(1)*xfac, ax_in.XLim(2)*xfac) + xshift;
            latScale = rescale(G.Nodes.lat, ax_in.YLim(1)*yfac, ax_in.YLim(2)*yfac) + yshift;
        else
            lonScale = rescale(G.Nodes.lon, ax_in.XLim(1), ax_in.XLim(2));
            latScale = rescale(G.Nodes.lat, ax_in.YLim(1), ax_in.YLim(2));
        end
    else
        lonScale = G.Nodes.lon;
        latScale = G.Nodes.lat;
    end
    plt = plot(ax_in, G, 'XData', lonScale, 'YData', latScale);
end

lineTF = any(strcmp('line', G.Nodes.Properties.VariableNames)) && ...
    ~isempty(G.Nodes.line);

generic_color_codes = {'#EC7063', '#AF7AC5', '#5DADE2', '#48C9B0', '#52BE80'...
    '#F4D03F', '#F5B041', '#DC7633', '#95A5A6', '#CCCCFF', '#FF00FF', '#808000'...
    '#FFCCCC', '#E6B0AA', '#D4E6F1', '#F8F9F9'};
color_idx = 1;

if lineTF
    lines = unique(G.Nodes.line);
    for i = 1:length(lines)
        Ni = G.Nodes.Name(cellfun(@(x) strcmp(x, lines{i}), G.Nodes.line));
        switch lines{i}
            case 'Blue'
                icol = '#3498DB';
                ishp = 'o';
            case 'Red'
                icol = '#EB0000';
                ishp = 'o';
            case 'Orange'
                icol = '#FF8700';
                ishp = 'o';
            case 'Green'
                icol = '#27AE60';
                ishp = 'o';
            case 'Commuter'
                icol = '#9B59B6';
                ishp = 'd';
            otherwise
                icol = generic_color_codes{color_idx};
                ishp = 'o';
                if color_idx < length(generic_color_codes)
                    color_idx = color_idx + 1;
                elseif color_idx == length(generic_color_codes)
                    color_idx = 1;
                end
        end
        highlight(plt, Ni', 'NodeColor', icol, 'Marker', ishp)
    end
    if scheck('MarkerSize')
        plt.MarkerSize = opts.MarkerSize;
    else
        plt.MarkerSize = 5;
    end
    ax = gca;
end

if ~scheck('nodeLabelsTF') || ~opts.nodeLabelsTF
    labelnode(plt, G.Nodes.Name, ' ')
end

% h1 = usamap([min(G.Nodes.lat) max(G.Nodes.lat)], ...
%             [min(G.Nodes.lon) max(G.Nodes.lon)]);
% setm(h1,'FFaceColor','#B7E9F7')
% opts1 = struct; opts1.ax_in = h1; opts1.scale = true;
% hold on; plot_MBTA_dev(G, opts1)

end