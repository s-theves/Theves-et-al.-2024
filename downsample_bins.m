function [bin_v_sq, bin_v_rct] = downsample_bins(v,bvc_v_sq,bvc_v_rct)

x_edges_sq = linspace(1, v.env.dx_sq, v.env.Nx_sq+1);
[~,xbins_sq] = histc(v.env.SquareSpaceX, x_edges_sq, 1);
y_edges_sq = linspace(1, v.env.dy_sq, v.env.Ny_sq+1);
[~,ybins_sq] = histc(v.env.SquareSpaceY, y_edges_sq, 1);

x_edges_rct = linspace(1, v.env.dx_rct, v.env.Nx_rct+1); 
[~,xbins_rct] = histc(v.env.RectSpaceX, x_edges_rct, 1); 
y_edges_rct = linspace(1, v.env.dy_rct, v.env.Ny_rct+1);
[~,ybins_rct] = histc(v.env.RectSpaceY, y_edges_rct, 1);

popvec_sq = reshape(bvc_v_sq', v.env.dy_sq-1, v.env.dx_sq-1, size(bvc_v_sq, 1)); 
popvec_rct = reshape(bvc_v_rct', v.env.dy_rct-1, v.env.dx_rct-1, size(bvc_v_rct, 1));

bin_mean_sq = zeros(v.env.Ny_sq, v.env.Nx_sq, v.bvc.N);
bin_mean_rct = zeros(v.env.Ny_rct, v.env.Nx_rct, v.bvc.N);

for pc = 1:v.bvc.N 
    for y = 1:v.env.Ny_sq 
        for x = 1:v.env.Nx_sq
            curr_pc = popvec_sq(:,:,pc);
            bin_mean_sq(y,x,pc) = mean(curr_pc(xbins_sq==x & ybins_sq==y));
        end
        for x = 1:v.env.Nx_rct 
            curr_pc = popvec_rct(:,:,pc);
            bin_mean_rct(y,x,pc) = mean(curr_pc(xbins_rct==x & ybins_rct==y));
        end
    end

end
bin_v_sq = reshape(bin_mean_sq, v.env.Nx_sq*v.env.Ny_sq, v.bvc.N);
bin_v_rct = reshape(bin_mean_rct, v.env.Nx_rct*v.env.Ny_rct, v.bvc.N);
end

