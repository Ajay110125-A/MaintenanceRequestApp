@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Priority Info'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_PRIORITY_INFO_AY
  as select from zaj_priority_ay as _Priority
{
  key priority_id   as PriorityId,
      priority_name as PriorityName
}
