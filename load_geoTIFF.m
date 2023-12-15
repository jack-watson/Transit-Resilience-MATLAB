function [A, R, info] = load_geoTIFF(filename)

% Parse input -------------------------------------------------------------
if isempty(regexp(filename, ".tif$", 'once')) % if input is a directory rather than a specific file
    tifnames = dir(filename + "\" + "*.tif");
    fullpaths = cellfun(@(x) filename + "\" + x, {tifnames.name});
else
    fullpaths = filename;
end


% Read GeoTIFF files ------------------------------------------------------
[cA, cR] = arrayfun(@(x) readgeoraster(x, "OutputType", "double"), ...
    fullpaths, 'UniformOutput', false);
info = arrayfun(@(x) georasterinfo(x), fullpaths); % get file metadata


% Preprocess data ---------------------------------------------------------
missingVal = info(1).MissingDataIndicator; % get missing value indicator
for i = 1:length(cA)
    cA{i} = standardizeMissing(cA{i},missingVal); % replace indicator with NaN
end

% Package output ----------------------------------------------------------
if length(cA) == 1
    A = cA{1};
    R = cR{1};
else
    A = cA;
    R = cR;
end

% Scratch -----------------------------------------------------------------

%filename = "D:\HEC_HMS_Projects\Boston_watersheds_02_30m\RAS\shortPlanID\Depth (03SEP2008 23 00 00).Boston_30m_DEM_clipped.Boston_30m_DEM_clipped.tif"; % for testing

end