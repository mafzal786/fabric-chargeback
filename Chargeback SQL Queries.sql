select w.[Workspaces_Workspace_name], c.[Capacities_Capacity_name],
cb.[Chargeback_Capacity_Id], cb.[Chargeback_Workspace_Id], CONVERT(DATETIME2(0),[Chargeback_Date],103) as process_date,
[Chargeback_CU_s_]
from [dbo].[chargeback] cb
join [dbo].[workspaces] w on w.Workspaces_Workspace_Id = cb.Chargeback_Workspace_Id
join [dbo].[capacities] c on c.Capacities_Capacity_Id = cb.Chargeback_Capacity_Id
where w.Workspaces_Workspace_name = 'DemoWS'
and CONVERT(DATETIME2(0),[Chargeback_Date],103) BETWEEN '5/19/2026' AND '6/18/2026'

declare @total_cu float
select @total_cu = sum([Chargeback_CU_s_]) from [dbo].[chargeback]
where CONVERT(DATETIME2(0),[Chargeback_Date],103) BETWEEN '6/08/2026' AND '6/15/2026'

--select @total_cu

select sum([Chargeback_CU_s_]) as utilization,(sum([Chargeback_CU_s_])/@total_cu)*100 as utilization_percent,
c.Capacities_Capacity_name, w.Workspaces_Workspace_name 
from [dbo].[chargeback] cb
join [dbo].[workspaces] w on w.Workspaces_Workspace_Id = cb.Chargeback_Workspace_Id
join [dbo].[capacities] c on c.Capacities_Capacity_Id = cb.Chargeback_Capacity_Id
--where w.Workspaces_Workspace_name = 'DemoWS'
and CONVERT(DATETIME2(0),[Chargeback_Date],103) BETWEEN '6/08/2026' AND '6/15/2026'
--and c.[Capacities_Capacity_name] = 'fabric4455eastus2'
group by c.Capacities_Capacity_name, w.Workspaces_Workspace_name