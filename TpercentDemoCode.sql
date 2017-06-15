USE [TC17Demo]
GO

/****** Object:  UserDefinedFunction [dbo].[tvfDrawTC17Percent]    Script Date: 5/9/2017 10:28:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*

SELECT * FROM tvfDrawTC17Percent('T 33 Percent', 33)
*/


CREATE FUNCTION [dbo].[tvfDrawTC17Percent]
(
@ShapeID varchar(20),
@FillPercent float
)
RETURNS
@PolySamples TABLE
( 
ShapeID varchar(20),
FillPercent float,
PointID int,
PointX float,
PointY float
)
AS
BEGIN

DECLARE @letterOutline geometry;  
DECLARE @letterSolid geometry;
DECLARE @meter geometry;

DECLARE @StartLine float = 0
DECLARE @EndLine decimal(9,6)
DECLARE @EndLineChar varchar(10)

SET @StartLine = 0
SET @EndLine = 2.0 * @FillPercent / 100.0
SET @EndLineChar = CONVERT(VARCHAR(10), @EndLine)

DECLARE @PolyString varchar(1000) 
DECLARE @T varchar(1000) = '(-1 2, 1 2, 1 1.5, 0.3 1.5, 0.3 0, -0.3 0, -0.3 1.5, -1 1.5, -1 2)'

SET @PolyString = 'POLYGON(' + @T + ')'

SET @letterSolid = geometry::Parse(@PolyString);  

SET @PolyString = 'LINESTRING' + @T 
SET @letterOutline = geometry::Parse(@PolyString).STBuffer(0.05)

SET @PolyString = 'POLYGON((-2 ' + @EndLineChar + ' , 2 ' + + @EndLineChar + ', 2 0, -2 0, -2 ' + @EndLineChar + '))'
SET @meter = geometry::Parse(@PolyString);

DECLARE @intersection geometry
SET @intersection = @meter.STIntersection(@letterSolid) 
SET @intersection = @intersection.STUnion(@letterOutline)

INSERT INTO @PolySamples
SELECT
@ShapeID AS ShapeID,
@FillPercent AS FillPercent,
PointID,
PointX,
PointY from [dbo].[tvfGetPolygonPoints](@intersection);

RETURN;

END


GO


