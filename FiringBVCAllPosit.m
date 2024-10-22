function FiringBVC = FiringBVCAllPosit(RatX, RatY, Dist2Walls, OptD,OptA,SigAng,Beta,Sig0)

DimensionRatX = size(RatX);
DimensionRatY = size(RatY);
FiringBVC = zeros(DimensionRatY(1),DimensionRatX(2));

for N = 1:prod(size(FiringBVC))
    FiringBVC(N) = firingBVC(RatX(N),RatY(N),Dist2Walls(N,:),OptD,OptA,SigAng,Beta,Sig0);
end






