select count(*)
from project..[Mac]
--2500

select *
from project..[Mac]
order by 1
-- full table

 SELECT [Machine_ID],count(*)
 from project..[Mac]
 group by [Machine_ID]
 having count(*)>1
 --Machine_ID              Count
 --Makino-L3-Unit1-2015 =	818
--Makino-L2-Unit1-2015	=   808
--Makino-L1-Unit1-2013	=   874

-- Get the average Hydraulic Pressure for each Machine_ID.
SELECT [Machine_ID], AVG([Hydraulic_Pressure_bar]) AS AvgHydraulic_Pressure_bar
FROM project..[Mac]
GROUP BY [Machine_ID];
--Machine_ID           AvgHydraulic_Pressure_bar
--Makino-L3-Unit1-2015	100.855378955018
--Makino-L2-Unit1-2015	103.403585337761
--Makino-L1-Unit1-2013	100.220547700202

-- Calculate the minimum and maximum Spindle Speed.
SELECT MIN([Spindle_Speed_RPM]) AS MinSpindle_Speed_RPM, MAX([Spindle_Speed_RPM]) AS MaxSpindle_Speed_RPM
FROM project..[Mac]
--MinSpindle_Speed_RPM = 0
---MaxSpindle_Speed_RPM = 27957

-- Find the Machine_ID with the highest Torque.
SELECT [Machine_ID], Torque_Nm
FROM project..[Mac]
WHERE Torque_Nm = (SELECT MAX([Torque_Nm]) 
FROM project..[Mac]);
--Machine_ID            Torque_Nm   
--Makino-L3-Unit1-2015	55.5523986816406

-- Calculate the average Cutting force for each Assembly Line.
SELECT Assembly_Line_No, AVG([Cutting_kN]) AS AvgCutting_kNForce
FROM project..[Mac]
GROUP BY Assembly_Line_No;
--Assembly_Line_No   AvgCutting_kNForce
--Shopfloor-L1	    2.7742268040964
--Shopfloor-L2	    2.79363975406433
--Shopfloor-L3	    2.78051533859932

-- Calculate the average Coolant Temperature for records with Machine Failure.
SELECT [Machine_ID], AVG([Coolant_Temperature]) AS AvgCoolantTempWithFailure
FROM project..[Mac]
WHERE Downtime = 'Machine_Failure'
GROUP BY [Machine_ID];
--Machine_ID            AvgCoolantTempWithFailure
--Makino-L3-Unit1-2015	19.9192770107683
--Makino-L2-Unit1-2015	20.3315655486752
--Makino-L1-Unit1-2013	19.7374448524173

-- Count the number of records with Machine Failure and a Spindle Speed above 25000 RPM.
SELECT [Machine_ID], COUNT(*) AS RecordsWithFailureAndHighSpeed
FROM project..[Mac]
WHERE Downtime = 'Machine_Failure' AND [Spindle_Speed_RPM] > 25000
GROUP BY [Machine_ID];
--Machine_ID            RecordsWithFailureAndHighSpeed
--Makino-L1-Unit1-2013	     131
--Makino-L2-Unit1-2015	     109
--Makino-L3-Unit1-2015	     106