function v = env_distances(v)

SquareWallVectors = [v.env.dx_sq,0, -v.env.dx_sq,0; 0,v.env.dy_sq, 0,-v.env.dy_sq];
SquareWallStart = [0,v.env.dx_sq,v.env.dx_sq,0; 0,0,v.env.dy_sq,v.env.dy_sq];
Interval = 1.0;

SquareXYmax = max(SquareWallStart');
SquareXYmin = min(SquareWallStart');

[SquareSpaceX,SquareSpaceY] = meshgrid(SquareXYmin(1)+Interval:Interval:SquareXYmax(1)-Interval, SquareXYmin(2)+Interval:Interval:SquareXYmax(2)-Interval);

SquareDist2Walls = zeros(numel(SquareSpaceX),100);
for N = 1:numel(SquareSpaceX) 
    SquareDist2Walls(N,:) = getDistances([SquareSpaceX(N);SquareSpaceY(N)], SquareWallVectors, SquareWallStart); % N = all positions (rows)
end

v.env.SquareDist2Walls = SquareDist2Walls;
v.env.SquareSpaceX = SquareSpaceX;
v.env.SquareSpaceY = SquareSpaceY;
v.env.SquareWallStart = SquareWallStart;
v.env.SquareWallVectors = SquareWallVectors;
v.env.SquareXYmax = SquareXYmax;
v.env.SquareXYmin = SquareXYmin;

RectWallVectors = [v.env.dx_rct,0, -v.env.dx_rct,0; 0,v.env.dy_rct, 0,-v.env.dy_rct];
RectWallStart = [0,v.env.dx_rct,v.env.dx_rct,0; 0,0,v.env.dy_rct,v.env.dy_rct];
Interval = 1.0; 

RectXYmax = max(RectWallStart');
RectXYmin = min(RectWallStart');

[RectSpaceX,RectSpaceY] = meshgrid(RectXYmin(1)+Interval:Interval:RectXYmax(1)-Interval, RectXYmin(2)+Interval:Interval:RectXYmax(2)-Interval);

RectDist2Walls = zeros(numel(RectSpaceX),100);
for N = 1:numel(RectSpaceX)
    RectDist2Walls(N,:) = getDistances([RectSpaceX(N);RectSpaceY(N)], RectWallVectors, RectWallStart); % N = all positions (rows)
end

v.env.RectDist2Walls = RectDist2Walls;
v.env.RectSpaceX = RectSpaceX;
v.env.RectSpaceY = RectSpaceY;
v.env.RectWallStart = RectWallStart;
v.env.RectWallVectors = RectWallVectors;
v.env.RectXYmax = RectXYmax;
v.env.RectXYmin = RectXYmin;

end