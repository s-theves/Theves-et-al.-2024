function Dist2Walls = getDistances(RatPosition, WallVectors, WallStart)

Dist2Walls = zeros(1,100);
for N = 1:length(WallVectors)
    Dist2Walls = Dist2Walls + distBoundary(RatPosition,WallStart(:,N), WallVectors(:,N));
end
