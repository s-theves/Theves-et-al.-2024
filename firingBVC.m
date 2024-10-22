function FiringBVC = firingBVC(RatX,RatY,Dist2Walls,OptD,OptA,SigAng,Beta,Sig0)

SigRad = zeros(size(Dist2Walls));
SigRad = Dist2Walls./Beta + Sig0;
TwoSigRadSqr = 2.*(SigRad.^2);

Step = 2/length(Dist2Walls);
Bearings = (0 : Step*pi : (2-Step)*pi);

TwoSigAngSqr = 2*(SigAng^2);

AngDif = zeros(size(Bearings));
AngDifCrude = zeros(size(Bearings));
TestVect1 = zeros(size(Bearings));
TestVect2 = zeros(size(Bearings));
AngDifCrude = ((Bearings-OptA).^2).^0.5;
TestVect1 = (AngDifCrude./pi)>1;
TestVect2 = (AngDifCrude./pi)<=1;

AngDif = (pi-(AngDifCrude-pi)).*TestVect1;
AngDif = AngDif + AngDifCrude.*TestVect2;

Firing = zeros(size(Dist2Walls));
Firing = (exp(-((Dist2Walls-OptD).^2)./TwoSigRadSqr))./((pi.*TwoSigRadSqr).^0.5) .* ...
         (exp(-((AngDif).^2)./TwoSigAngSqr))./((pi*TwoSigAngSqr)^0.5);


FiringBVC = sum(Firing);