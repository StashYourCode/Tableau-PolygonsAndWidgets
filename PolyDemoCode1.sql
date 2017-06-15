USE TC17Demo
GO

DECLARE @g geometry;  
DECLARE @g2 geometry;

SET @g = geometry::Parse('CIRCULARSTRING(2 1, 1 2, 0 1, 1 0, 2 1)');  
SELECT @g, 'Circumference = ' + CAST(@g.STLength() AS NVARCHAR(10));  
--set @g2 = @g.STBuffer(1).STBuffer(-1);
set @g2 = @g.STCurveToLine();
select * from tvfGetPolygonPoints(@g2)

declare @i integer = 1;
select @i;

while (@i < @g2.STNumPoints())
begin
 select @i, @g2.STPointN(@i).STX AS PointX, @g2.STPointN(@i).STY AS PointY
 set @i = @i + 1
end