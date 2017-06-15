
DECLARE @Durham geography = 'POINT(-78.902734 35.996220)'
DECLARE @Raleigh geography = 'POINT(-78.644228 35.785884)'
DECLARE @ChapelHill geography = 'POINT(-79.034485 35.928460)'

DECLARE @BufferInMeters float = 24140.2 -- 15 miles

SELECT @Durham.STBuffer(@BufferInMeters)
UNION ALL
SELECT @Raleigh.STBuffer(@BufferInMeters)
UNION ALL
SELECT @ChapelHill.STBuffer(@BufferInMeters)

--Get the 15 mile intersection of Raliegh and Durham
DECLARE @Intersection geography
SET @Intersection = @Durham.STBuffer(@BufferInMeters).STIntersection(@Raleigh.STBuffer(@BufferInMeters))
SELECT @Intersection

-- Get the 15 mile intersection of Chapel Hill to the existing intersection
SET @Intersection = @Intersection.STIntersection(@ChapelHill.STBuffer(@BufferInMeters))
SELECT @Intersection

SELECT * INTO ##TriangleIntersection from dbo.tvfGetGeographyPoints(@Intersection)

SELECT * FROM ##TriangleIntersection
