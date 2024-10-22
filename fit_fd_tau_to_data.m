function [tau] = fit_fd_tau_to_data(euclidean_distances,similarity_distribution,df,v)
fun = @(x) tau_fit(df, v, similarity_distribution, euclidean_distances, x(1));

tau = ...
    fmincon(fun, ...
    v.fit.tau_init, [],[],[],[], v.fit.tau_lb, v.fit.tau_ub, [], ...
    optimset('TolX', 0.0001, 'TolFun', 0.0001, 'MaxFunEvals', 1000, 'Algorithm', 'interior-point'));

end

function llik = tau_fit(df, v, similarity_distribution, euclidean_distances, tau)

probability_distribution = zeros(size(euclidean_distances));

% Create response probabilities based on softmax function with tau
for object_id = 1:5
    for p = 1:size(euclidean_distances,2)
        probability_distribution(object_id,p,:) = exp(similarity_distribution(object_id,p,:)/tau) / sum(exp(similarity_distribution(object_id,p,:)/tau));  % without the minus!! % ST Why c.f. Hartley
    end
end
probability_distribution = reshape(probability_distribution, 5, v.env.Ny_sq, v.env.Nx_sq, v.env.Ny_rct, v.env.Nx_rct);

ll = 0;
objects = ['A','B','C','D','E'];
for i = 1:height(df)
    object_id = find(objects == df.Location{i});
    p_obj = reshape(probability_distribution(object_id, df(i,:).Target2, df(i,:).Target1,:,:), v.env.Ny_rct, v.env.Nx_rct);
    ll = ll + log(p_obj(df(i,:).Resp2, df(i,:).Resp1));
end
llik = -ll;

end

