function v = generate_main_variables()
%Retrieves the variables for modelling and analyses

% Environment parameters
v.env.dx_sq = 100;
v.env.dy_sq = 100;
v.env.dx_rct = 173;
v.env.dy_rct = 100;
v.env.bin_size = 9.1;

v.env.Nx_sq = round(v.env.dx_sq/v.env.bin_size);
v.env.Ny_sq = round(v.env.dy_sq/v.env.bin_size);
v.env.Nx_rct = round(v.env.dx_rct/v.env.bin_size);
v.env.Ny_rct = round(v.env.dy_rct/v.env.bin_size);

% BVC parameters. Determines the characteristics of firing fields.
v.bvc.sig_d0  = 200; %
v.bvc.beta  = inf; % makes distal tuning width fixed for concept space
v.bvc.sig_a  = pi/16;
v.bvc.ang_tunings = pi*(0:3)/2;
v.bvc.max_tuning = v.env.dx_rct;
v.bvc.n_dist_tunings = 20;

% Fitting parameters
v.fit.tau_init = 0.1;
v.fit.tau_lb = 0;
v.fit.tau_ub = 5;

end

