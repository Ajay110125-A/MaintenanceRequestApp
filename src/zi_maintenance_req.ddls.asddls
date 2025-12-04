@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Maintenance Req'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_MAINTENANCE_REQ
  as select from zaj_maint_req as _Main
  composition [1..*] of ZI_MAINTENANCE_TASK as _Task
  association [1..1] to ZI_SITE_INFO_AY     as _Site     on _Main.siteid = _Site.SiteId
  association [1..1] to ZI_PRIORITY_INFO_AY as _Priority on _Main.priority = _Priority.PriorityId
  association [1..1] to ZI_STATUS_INFO_AY   as _Status   on _Main.status = _Status.StatusId
  association [1..1] to ZI_EQUIP_DETAILS    as _Equip    on _Main.equipmentid = _Equip.EquipmentId

{
  key request_uuid           as RequestUUId,
      request_id             as RequestId,
      equipmentid            as EquipmentId,
      _Equip.EquipName       as EquipmentName,
      siteid                 as SiteId,
      _Site.SiteName         as Site,
      priority               as PriorityId,
      _Priority.PriorityName as Priority,
      description            as Description,
      status                 as StatusId,
      _Status.StatusName     as Status,
      requested_date         as RequestedDate,

      @Semantics.user.createdBy: true
      local_created_by       as LocalCreatedBy,

      @Semantics.systemDateTime.createdAt: true
      local_created_at       as LocalCreatedAt,

      @Semantics.user.lastChangedBy: true
      local_last_changed_by  as LocalLastChangedBy,

      @Semantics.systemDateTime.lastChangedAt: true
      local_last_changed_at  as LocalLastChangedAt,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at        as LastChangedAt,
      _Task,
      _Site,
      _Priority,
      _Status,
      _Equip
}
