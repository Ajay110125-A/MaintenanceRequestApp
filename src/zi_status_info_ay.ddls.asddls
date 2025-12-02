@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Status Info'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_STATUS_INFO_AY
  as select from zaj_status_ay as _Status
{
  key status_id   as StatusId,
      status_name as StatusName
}
