dataset = 'defcon_rct_46pp.txt';

% Fixed variables
v = generate_main_variables();

% Run fitting function 
[bvc_loglik,fr_loglik, fd_loglik, uniform_loglik, bvc_prob, fr_prob, fd_prob, bvc_logprob, fr_logprob, fd_logprob] = fit_bvc_and_other_models(v, dataset);

df = readtable(dataset);
uniform_logprob = repmat(log(1/(11*19)),height(df),1);


objects = ['A','B','C','D','E'];
subjects = unique(df.Subject);
[trial_object_subject_bvc_logprob,trial_object_subject_fr_logprob,trial_object_subject_fd_logprob,trial_object_subject_uniform_logprob,...
    bvc_dists, fr_dists, fd_dists] = deal(zeros(5,length(objects),length(subjects)));
old_subject_id = 0;
old_object_id = 0;
[y_bvc_max, x_bvc_max, y_fr_max, x_fr_max, y_fd_max, x_fd_max] = deal(zeros(1,5));
for i = 1:5
    [y_bvc_max(i), x_bvc_max(i)] = find(squeeze(bvc_prob(i,:,:)) == max(bvc_prob(i,:,:),[],'all'));
    [y_fr_max(i), x_fr_max(i)] = find(squeeze(fr_prob(i,:,:)) == max(fr_prob(i,:,:),[],'all'));
    [y_fd_max(i), x_fd_max(i)] = find(squeeze(fd_prob(i,:,:)) == max(fd_prob(i,:,:),[],'all'));
end

for i = 1:height(df)
    object_id = find(objects == df.Location{i});
    subject_id = find(subjects == df.Subject(i));
    if (subject_id ~= old_subject_id) || (object_id ~= old_object_id) 
        trial = 1;
    else
        trial = trial+1;
    end
        trial_object_subject_bvc_logprob(trial,object_id,subject_id) = bvc_logprob(i);
        trial_object_subject_fr_logprob(trial,object_id,subject_id) = fr_logprob(i);
        trial_object_subject_fd_logprob(trial,object_id,subject_id) = fd_logprob(i);
        trial_object_subject_uniform_logprob(trial,object_id,subject_id) = uniform_logprob(i);
        bvc_dists(trial,object_id,subject_id) = sqrt(sum((y_bvc_max(object_id)-df.Resp2(i))^2 + (x_bvc_max(object_id)-df.Resp1(i))^2));
        fr_dists(trial,object_id,subject_id) = sqrt(sum((y_fr_max(object_id)-df.Resp2(i))^2 + (x_fr_max(object_id)-df.Resp1(i))^2));
        fd_dists(trial,object_id,subject_id) = sqrt(sum((y_fd_max(object_id)-df.Resp2(i))^2 + (x_fd_max(object_id)-df.Resp1(i))^2));        
        old_subject_id = subject_id;
        old_object_id = object_id;
end