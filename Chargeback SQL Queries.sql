-- Sample Query to calculate CU and CU percentage from the raw data
-- Get total capacity unit across all workspaces between the date range specified  
declare @total_cu float
declare @startdate DATETIME2
declare @enddate DATETIME2

set @startdate = '8/01/2026'
set @enddate = '8/31/2026'
  
select @total_cu = sum([Chargeback_CU_s_]) from [dbo].[chargeback]
where CONVERT(DATETIME2(0),[Chargeback_Date],103) BETWEEN @startdate AND @enddate

--select @total_cu

-- Get total CU and percent CU by capacity and workspaces
  
select sum([Chargeback_CU_s_]) as utilization,(sum([Chargeback_CU_s_])/@total_cu)*100 as utilization_percent,
c.Capacities_Capacity_name, w.Workspaces_Workspace_name 
from [dbo].[chargeback] cb
join [dbo].[workspaces] w on w.Workspaces_Workspace_Id = cb.Chargeback_Workspace_Id
join [dbo].[capacities] c on c.Capacities_Capacity_Id = cb.Chargeback_Capacity_Id
-- where w.Workspaces_Workspace_name = 'DemoWS'
and CONVERT(DATETIME2(0),[Chargeback_Date],103) BETWEEN @startdate AND @enddate
--and c.[Capacities_Capacity_name] = 'fabric capacity'
group by c.Capacities_Capacity_name, w.Workspaces_Workspace_name
