function Lengths = distBoundary (RatPosition, WallStart, WallVector)

WallVectorX = repmat(WallVector(1,1),1,100);
WallVectorY = repmat(WallVector(2,1),1,100);

RatPositionX = RatPosition(1);
RatPositionY = RatPosition(2);
WallStartX = WallStart(1);
WallStartY = WallStart(2);

Bearings = 0 : 0.02*pi : 1.98*pi;
BearingsVectorX = sin(Bearings); 
BearingsVectorY = cos(Bearings);

Determinants = BearingsVectorX .* WallVectorY - WallVectorX .* BearingsVectorY;

Lengths = (WallVectorY./ Determinants).*(WallStartX - RatPositionX) + (-WallVectorX./ Determinants).*(WallStartY - RatPositionY);

WallScalingFactor = -((-BearingsVectorY ./ Determinants).*(WallStartX - RatPositionX) + (BearingsVectorX ./ Determinants).*(WallStartY - RatPositionY));
Lengths = Lengths.* (( WallScalingFactor <= 1) & (WallScalingFactor >= 0));

Lengths = Lengths.* (Lengths >= 0);

Lengths(find(isnan(Lengths))) = 0;




