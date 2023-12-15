function tf = check_inundation(idx, mdepth, threshold)

depths = mdepth(idx);

if nargin > 2
    tf = depths >= threshold; % water depth threshold defined by input
else
    tf = depths >= 0.0254;  % half-inch (in meters) default
end

end

% [arclen, azimuth] = distance([plat, plon], [mlat(1), mlon(1)], ellipsoid);
% distfun = @(ylat, xlon) distance([plat, plon], [ylat, xlon], ellipsoid);
% Dm = arrayfun(@(Y, X) distfun(Y,X), mlat, mlon); % distance to each point in meters
% [~, Imin] = min(Dm, [], 'all');
% locDepth = mdepth(Imin);


% trying to find a more efficient approach than current @distfun
% implementation...
% [Ii,Jj] = geographicToDiscrete(cgR{end}, plat, plon);


% tflat = false(size(mlat)); % preallocate logical matrices
% tflon = false(size(mlon));
% 
% for ii = 1:size(mlat,2)
%     tflat(Iy, 1) = 1; %fill logical matrices
% end
% for jj = 1:size(mlon,2)
%     tflon(Ix(jj), jj) = 1; 
% end

%A(A > -0.15 & A < 0.15)
%mdepth((mlat > ) & ())

% mdepth = mA(:,:,end); mdepth(1,:) = [];

% plat = pcoords(1);
% plon = pcoords(2);
% 
% 
% 
% d = (plon-mlon).^2+(plat-mlat).^2; %// compute squared distances
% [~, dind] = min(d(:)); %// minimize distance and obtain (linear) index of minimum
% locDepth = mdepth(dind);
% 
% if nargin >= 6
%     tf = locDepth >= threshold;
% else
%     tf = locDepth > 0.0254;
% end