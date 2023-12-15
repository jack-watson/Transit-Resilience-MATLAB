function dI = get_closest_gridcell_index(plat, plon, mlat, mlon)

dI = zeros(size(plat));

for i = 1:length(plat)
    d = (plon(i)-mlon).^2+(plat(i)-mlat).^2; %// compute squared distances
    [~, dind] = min(d(:)); %// minimize distance and obtain (linear) index of minimum
    dI(i) = dind;
end

end