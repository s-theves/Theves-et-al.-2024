function bvc_pop = generate_bvc_firing(v)

bvc_pop = cell(v.bvc.N, 1);
FiringSquare = zeros(size(v.env.SquareSpaceY,1),size(v.env.SquareSpaceX,2));
FiringRect = zeros(size(v.env.RectSpaceY,1),size(v.env.RectSpaceX,2));

c = 1;
for d = 1:length(v.bvc.dist_tunings) % for all preferred distances
    for a = 1:length(v.bvc.ang_tunings) % for all preferred angles

        bvc_pop{c}.dist_tuning = v.bvc.dist_tunings(d);
        bvc_pop{c}.ang_tuning = v.bvc.ang_tunings(a);
        bvc_pop{c}.sig_a = v.bvc.sig_a;
        bvc_pop{c}.beta = v.bvc.beta;
        bvc_pop{c}.sig_d0 = v.bvc.sig_d0;

        % Compute firing field of BVC
        bvc_pop{c}.FiringSquare = FiringSquare;
        bvc_pop{c}.FiringSquare = bvc_pop{c}.FiringSquare + FiringBVCAllPosit(...
            v.env.SquareSpaceX, v.env.SquareSpaceY, v.env.SquareDist2Walls, bvc_pop{c}.dist_tuning,bvc_pop{c}.ang_tuning,bvc_pop{c}.sig_a,bvc_pop{c}.beta,bvc_pop{c}.sig_d0);
        bvc_pop{c}.FiringRect = FiringRect;
        bvc_pop{c}.FiringRect = bvc_pop{c}.FiringRect + FiringBVCAllPosit(...
            v.env.RectSpaceX, v.env.RectSpaceY, v.env.RectDist2Walls, bvc_pop{c}.dist_tuning,bvc_pop{c}.ang_tuning,bvc_pop{c}.sig_a,bvc_pop{c}.beta,bvc_pop{c}.sig_d0);

        c = c + 1;
    end
end
end

