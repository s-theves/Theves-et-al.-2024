function [fd_bin_v_sq,fd_bin_v_rct] = get_fixed_distances(v)

fd_sq = zeros(5,2,v.env.Ny_sq, v.env.Nx_sq);
fd_rct = zeros(5,2,v.env.Ny_rct,v.env.Nx_rct);

for y = 1:v.env.Ny_sq
    for x = 1:v.env.Nx_sq
        fd_sq(1,:,y,x) = [x-0.5, v.env.Ny_sq-y+0.5];
    end
    for x = 1:v.env.Nx_rct
        fd_rct(1,:,y,x) = [x-0.5, v.env.Ny_sq-y+0.5];
    end
end
for y = 1:v.env.Ny_sq
    for x = 1:v.env.Nx_sq
        fd_sq(2,:,y,x) = [x-0.5, y-0.5];
    end
    for x = 1:v.env.Nx_rct
        fd_rct(2,:,y,x) = [x-0.5, y-0.5];
    end
end
for y = 1:v.env.Ny_sq
    for x = 1:v.env.Nx_sq
        fd_sq(3,:,y,x) = [v.env.Nx_sq-x+0.5, y-0.5];
    end
    for x = 1:v.env.Nx_rct
        fd_rct(3,:,y,x) = [v.env.Nx_rct-x+0.5, y-0.5];
    end
end
for y = 1:v.env.Ny_sq
    for x = 1:v.env.Nx_sq
        fd_sq(4,:,y,x) = [x-0.5, y-0.5];
    end
    for x = 1:v.env.Nx_rct
        fd_rct(4,:,y,x) = [x-0.5, y-0.5];
    end
end
for y = 1:v.env.Ny_sq
    for x = 1:v.env.Nx_sq
        fd_sq(5,:,y,x) = [v.env.Nx_sq-x+0.5, v.env.Ny_sq-y+0.5];
    end
    for x = 1:v.env.Nx_rct
        fd_rct(5,:,y,x) = [v.env.Nx_rct-x+0.5, v.env.Ny_rct-y+0.5];
    end
end

fd_bin_v_sq = zeros(5,v.env.Ny_sq*v.env.Nx_sq, 2); 
fd_bin_v_rct = zeros(5,v.env.Ny_rct*v.env.Nx_rct, 2); 

for object_id = 1:5
    for i = 1:2
        fd_bin_v_sq(object_id,:,i) = fd_sq(object_id,i,:);
        fd_bin_v_rct(object_id,:,i) = fd_rct(object_id,i,:);
    end
end

end

