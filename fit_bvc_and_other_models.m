function [bvc_loglik,fr_loglik, fd_loglik, uniform_loglik, bvc_prob, fr_prob, fd_prob, bvc_logprob, fr_logprob, fd_logprob] = fit_bvc_and_other_models(v, dataset)

% Generate bvc tunings
v = calculate_bvc_tunings(v);
% Create environment based on resolution and aspect ratio
v = env_distances(v);
bvc_pop = generate_bvc_firing(v);

%=========================================================================%
%----------------------- Get Population Vectors --------------------------%
%-------------------------- Compute Distances ----------------------------%
%=========================================================================%

% Create population vectors (BVCs as rows)
bvc_v_sq = zeros(v.bvc.N, length(bvc_pop{1}.FiringSquare(:))); % BVC*state matrix
bvc_v_rct = zeros(v.bvc.N, length(bvc_pop{1}.FiringRect(:))); % BVC*state matrix

for bvc = 1:v.bvc.N % for all bvc's
    bvc_v_sq(bvc,:) = bvc_pop{bvc}.FiringSquare(:);
    bvc_v_rct(bvc,:) = bvc_pop{bvc}.FiringRect(:);
end
[fr_bin_v_sq,fr_bin_v_rct] = get_fixed_ratios(v);
[fd_bin_v_sq,fd_bin_v_rct] = get_fixed_distances(v);

% BINNING
[bvc_bin_v_sq, bvc_bin_v_rct] = downsample_bins(v,bvc_v_sq,bvc_v_rct);

%=========================================================================%
%----------------------- BETWEEN-ENV SIMILARITY --------------------------%
%----------------------- Replacement Predictions -------------------------%
%=========================================================================%

[bvc_dist,bvc_sim] = get_similarity_distributions(bvc_bin_v_sq,bvc_bin_v_rct);
[fr_dist,fr_sim] = get_similarity_distributions(fr_bin_v_sq,fr_bin_v_rct);
fd_dist = zeros([5,size(fr_dist)]);
fd_sim = zeros([5,size(fr_sim)]);
for object_id = 1:5
    [fd_dist(object_id,:,:),fd_sim(object_id,:,:)] = get_similarity_distributions(squeeze(fd_bin_v_sq(object_id,:,:)),squeeze(fd_bin_v_rct(object_id,:,:)));
end

%=========================================================================%
%--------------------------- FIT to DATA  --------------------------------%
%=========================================================================%

df = readtable(dataset);
objects = ['A','B','C','D','E'];

bvc_tau = fit_tau_to_data(bvc_dist,bvc_sim,df,v);
fr_tau = fit_tau_to_data(fr_dist,fr_sim,df,v);
fd_tau = fit_fd_tau_to_data(fd_dist,fd_sim,df,v);

[bvc_prob, fr_prob, fd_prob, uni_prob] = deal(zeros(5, v.env.Ny_rct, v.env.Nx_rct));
tmp_bvc_prob = reshape(bvc_sim, v.env.Ny_sq, v.env.Nx_sq, v.env.Ny_rct, v.env.Nx_rct);
tmp_fr_prob = reshape(fr_sim, v.env.Ny_sq, v.env.Nx_sq, v.env.Ny_rct, v.env.Nx_rct);
tmp_fd_prob = reshape(fd_sim, 5, v.env.Ny_sq, v.env.Nx_sq, v.env.Ny_rct, v.env.Nx_rct);

for object_id = 1:5
    object = objects(object_id);
    i = find(cell2mat(df.Location(:)) == object,1);
    bvc_prob(object_id,:,:) = make_softmax_distribution(tmp_bvc_prob(df(i,:).Target2, df(i,:).Target1,:,:), bvc_tau);
    fr_prob(object_id,:,:) = make_softmax_distribution(tmp_fr_prob(df(i,:).Target2, df(i,:).Target1,:,:), fr_tau);
    fd_prob(object_id,:,:) = make_softmax_distribution(tmp_fd_prob(object_id,df(i,:).Target2, df(i,:).Target1,:,:), fd_tau);
    uni_prob(object_id,:,:) = ones(v.env.Ny_rct, v.env.Nx_rct) / (v.env.Ny_rct*v.env.Nx_rct);
end
delete tmp*

[bvc_logprob, fr_logprob, fd_logprob] = deal(zeros(height(df),1));
[bvc_loglik, fr_loglik, fd_loglik, uniform_loglik] = deal(0);

for i = 1:height(df)
    object_id = find(objects == df.Location{i});
    bvc_logprob(i) = log(bvc_prob(object_id,df(i,:).Resp2, df(i,:).Resp1)); 
    bvc_loglik = bvc_loglik + bvc_logprob(i); 
    fr_logprob(i) = log(fr_prob(object_id,df(i,:).Resp2, df(i,:).Resp1)); 
    fr_loglik = fr_loglik + fr_logprob(i); 
    fd_logprob(i) = log(fd_prob(object_id,df(i,:).Resp2, df(i,:).Resp1));
    fd_loglik = fd_loglik + fd_logprob(i); 
    uniform_loglik = uniform_loglik + log(uni_prob(object_id,df(i,:).Resp2, df(i,:).Resp1));
end


end 


