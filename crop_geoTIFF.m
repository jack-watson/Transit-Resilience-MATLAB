function [B, cR] = crop_geoTIFF(A, R)

if ~iscell(A)
    A = {A};
end
if ~iscell(R)
    R = {R};
end

B = cell(size(A));
cR = cell(size(R));

for i = 1:length(A)
    Ri = R{i};
    Ai = A{i};

    [X,Y] = worldGrid(Ri);
    
    % crop into smallest rectangle that contains all non-placeholder values
    xistart = find(~isnan(nanmean(Ai,1)), 1, "first");
    xiend = find(~isnan(nanmean(Ai,1)), 1, "last");
    yistart = find(~isnan(nanmean(Ai,2)), 1, "first");
    yiend = find(~isnan(nanmean(Ai,2)), 1, "last");
    
    xlimits = X(1, [xistart, xiend]);
    ylimits = (Y([yiend, yistart], 1))';

    [B{i}, cR{i}] = mapcrop(Ai, Ri, xlimits, ylimits);
end

end