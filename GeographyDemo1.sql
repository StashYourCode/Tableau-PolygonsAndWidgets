USE AdventureWorks2012  
GO  
DECLARE @g geography = 'POINT(-121.626 47.8315)';  
SELECT TOP(7) SpatialLocation.ToString(), SpatialLocation.Lat, SpatialLocation.Long, City FROM Person.Address  
ORDER BY SpatialLocation.STDistance(geography::Parse('POINT(-121.626 47.8315)')); 

SELECT  geography::UnionAggregate(SpatialLocation) AS AddressCollection
 FROM 
 (
 SELECT TOP(7) SpatialLocation FROM Person.Address  
ORDER BY SpatialLocation.STDistance(geography::Parse('POINT(-121.626 47.8315)'))
) P
 
 SELECT  geography::EnvelopeAggregate(SpatialLocation) AS AddressCollection
 FROM 
 (
 SELECT TOP(7) SpatialLocation FROM Person.Address  
ORDER BY SpatialLocation.STDistance(geography::Parse('POINT(-121.626 47.8315)'))
) P

 SELECT  geography::EnvelopeAggregate(SpatialLocation) AS AddressCollection
 FROM 
 (
 SELECT TOP(7) SpatialLocation FROM Person.Address  
ORDER BY SpatialLocation.STDistance(geography::Parse('POINT(-121.626 47.8315)'))
) P
UNION ALL
SELECT  geography::UnionAggregate(SpatialLocation) AS AddressCollection
 FROM 
 (
 SELECT TOP(7) SpatialLocation FROM Person.Address  
ORDER BY SpatialLocation.STDistance(geography::Parse('POINT(-121.626 47.8315)'))
) P