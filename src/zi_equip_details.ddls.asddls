@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Equiptment Details Interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_EQUIP_DETAILS
  as select from zaj_euip_details as _Equip
{
  key equipmentid       as EquipmentId,
      equip_name        as EquipName,
      model_no          as ModelNo,
      manufacturer      as ManufacturerId,
      serial_no         as SerialNo,
      installation_date as InstallationDate,
      warrant_end_date  as WarrantEndDate
}
