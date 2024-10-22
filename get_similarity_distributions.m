function [euclidean_distances,similarity_distribution] = get_similarity_distributions(bin_v_sq,bin_v_rct)

euclidean_distances = zeros(size(bin_v_sq,1), size(bin_v_rct,1));

for s1 = 1:size(bin_v_sq,1)
    for s2 = 1:size(bin_v_rct,1)
        euclidean_distances(s1,s2) = sqrt(sum((bin_v_sq(s1,:) - bin_v_rct(s2,:)).^2));
    end
end

similarity_distribution = zeros(size(euclidean_distances));
for w = 1:size(bin_v_sq, 1)
    similarity_distribution(w,:) = (max(euclidean_distances(w,:)) - euclidean_distances(w,:));
end
end