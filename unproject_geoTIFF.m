function [lat,lon] = unproject_geoTIFF(R)

if iscell(R)
    R = R{1};
end

% parse input, get coordinates, unproject ---------------------------------
if class(R) == "map.rasterref.MapCellsReference"
    [X,Y] = worldGrid(R);
end

p = R.ProjectedCRS;
[lat,lon] = projinv(p,X,Y);

end