@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Maintenance Task'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_MAINTENANCE_TASK
  as select from zaj_maint_tsk as _Task
  association        to parent ZI_MAINTENANCE_REQ as _Main   on $projection.RequestUUId = _Main.RequestUUId
  association [1..1] to ZI_TECH_INFO_AY           as _Tech   on _Task.techinician_id = _Tech.TechnicianId
  association [1..1] to ZI_STATUS_INFO_AY         as _Status on _Task.task_status = _Status.StatusId
{
  key task_uuid             as TaskUUId,
      request_uuid          as RequestUUId,
      task_id               as TaskId,
      schedule_start        as ScheduleStart,
      schedule_end          as ScheduleEnd,
      actual_start          as ActualStart,
      actual_end            as ActualEnd,
      techinician_id        as TechnicianId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      estimated_cost        as EstimatedCost,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      actual_cost           as ActualCost,
      currency_code         as CurrencyCode,
      task_status           as TaskStatus,
      notes                 as TechNote,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,


      _Main,
      _Tech,
      _Status
}
