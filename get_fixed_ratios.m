function [fr_bin_v_sq,fr_bin_v_rct] = get_fixed_ratios(v)

fr_sq = zeros(2,v.env.Ny_sq, v.env.Nx_sq);
fr_rct = zeros(2,v.env.Ny_rct,v.env.Nx_rct);

for y = 1:v.env.Ny_sq
    for x = 1:v.env.Nx_sq
        fr_sq(:,y,x) = [(x-0.5)/v.env.Nx_sq, (y-0.5)/v.env.Ny_sq];
    end
    for x = 1:v.env.Nx_rct
        fr_rct(:,y,x) = [(x-0.5)/v.env.Nx_rct, (y-0.5)/v.env.Ny_rct];
    end
end

fr_bin_v_sq = zeros(v.env.Ny_sq*v.env.Nx_sq, 2);
fr_bin_v_rct = zeros(v.env.Ny_rct*v.env.Nx_rct, 2); 

for i = 1:2 
    fr_bin_v_sq(:,i) = fr_sq(i,:);
    fr_bin_v_rct(:,i) = fr_rct(i,:);
end

end

