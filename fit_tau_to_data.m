function [tau] = fit_tau_to_data(euclidean_distances,similarity_distribution,df,v)

fun = @(x) tau_fit(df, v, similarity_distribution, euclidean_distances, x(1));

tau = ...
    fmincon(fun, ...
    v.fit.tau_init, [],[],[],[], v.fit.tau_lb, v.fit.tau_ub, [], ...
    optimset('TolX', 0.0001, 'TolFun', 0.0001, 'MaxFunEvals', 10000, 'Algorithm', 'interior-point'));

end

function llik = tau_fit(ds, v, similarity_distribution, euclidean_distances, tau)

probability_distribution = zeros(size(euclidean_distances));

% Create response probabilities based on softmax function with tau
for p = 1:size(euclidean_distances,1)
    probability_distribution(p,:) = exp(similarity_distribution(p,:)/tau) / sum(exp(similarity_distribution(p,:)/tau));
end
probability_distribution = reshape(probability_distribution, v.env.Ny_sq, v.env.Nx_sq, v.env.Ny_rct, v.env.Nx_rct);

ll = 0;
for i = 1:height(ds)
    p_obj = reshape(probability_distribution(ds(i,:).Target2, ds(i,:).Target1,:,:), v.env.Ny_rct, v.env.Nx_rct);  % probability field for target object coordinates
    ll = ll + log(p_obj(ds(i,:).Resp2, ds(i,:).Resp1));
end
llik = -ll; 

end

