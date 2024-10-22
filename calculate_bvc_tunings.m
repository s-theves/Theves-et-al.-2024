function v = calculate_bvc_tunings(v)

sig_d0 = v.bvc.sig_d0;
beta = v.bvc.beta; 
max_d = v.bvc.max_tuning;
n_eqns = v.bvc.n_dist_tunings;

alpha = sym('alpha');
eqn_vars = alpha;
for i = 1:(n_eqns-1)
    eval(sprintf("x%i = sym('x%i');",i,i));
    eval(sprintf('eqn_vars = [eqn_vars, x%i];',i));
end


eqn1 = x1 == (x1/beta + sig_d0)/alpha;
all_eqns = eqn1;
for i = 2:(n_eqns-1)
    eval(sprintf('eqn%i = x%i == x%i + (x%i/beta + x%i/beta + 2*sig_d0)/alpha;',i,i,i-1,i-1,i));
    eval(sprintf('all_eqns = [all_eqns, eqn%i];',i));
end
eval(sprintf('eqn%i = max_d == x%i + (x%i/beta + max_d/beta + 2*sig_d0)/alpha;',n_eqns,n_eqns-1,n_eqns-1));
eval(sprintf('all_eqns = [all_eqns, eqn%i];',n_eqns));

sol = solve(all_eqns, eqn_vars);

sol_id = find( double(sol.x1) == real(double(sol.x1)) .* (real(double(sol.x1)) > 0) );
dist_tunings = zeros(1,n_eqns);
dist_tunings(n_eqns) = max_d;
for i = 1:(n_eqns-1)
    eval(sprintf('dist_tunings(i) = sol.x%i(sol_id);',i,i));
end

v.bvc.alpha = double(sol.alpha(sol_id)); 
v.bvc.dist_tunings = dist_tunings;
v.bvc.N = length(v.bvc.dist_tunings) * length(v.bvc.ang_tunings);
end

