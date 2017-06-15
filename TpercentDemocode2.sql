DECLARE @letterOutline geometry;  
DECLARE @letterSolid geometry;
DECLARE @meter geometry;

DECLARE @StartLine float = 0
DECLARE @EndLine decimal(9,6)
DECLARE @EndLineChar varchar(10)

DECLARE @FillPercent int = 75

SET @StartLine = 0
SET @EndLine = 2.0 * @FillPercent / 100.0
SET @EndLineChar = CONVERT(VARCHAR(10), @EndLine)

DECLARE @PolyString varchar(1000) 
DECLARE @T varchar(1000) = '(-1 2, 1 2, 1 1.5, 0.3 1.5, 0.3 0, -0.3 0, -0.3 1.5, -1 1.5, -1 2)'

SET @PolyString = 'POLYGON(' + @T + ')'

SET @letterSolid = geometry::Parse(@PolyString);  

SELECT @letterSolid

SET @PolyString = 'LINESTRING' + @T 
SET @letterOutline = geometry::Parse(@PolyString).STBuffer(0.05)

SELECT @letterOutline

SET @PolyString = 'POLYGON((-2 ' + @EndLineChar + ' , 2 ' + + @EndLineChar + ', 2 0, -2 0, -2 ' + @EndLineChar + '))'
SET @meter = geometry::Parse(@PolyString);

SELECT @meter

DECLARE @intersection geometry
SET @intersection = @meter.STIntersection(@letterSolid) 
SET @intersection = @intersection.STUnion(@letterOutline)

SELECT @intersection