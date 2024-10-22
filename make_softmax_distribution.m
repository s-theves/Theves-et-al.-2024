function [probability_distribution] = make_softmax_distribution(distribution,tau)
probability_distribution = exp(distribution/tau) / sum(exp(distribution/tau),'all');
end

