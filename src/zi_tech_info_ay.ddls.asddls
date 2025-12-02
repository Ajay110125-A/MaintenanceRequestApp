@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Technician Info'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_TECH_INFO_AY
  as select from zaj_tech_info as _Tech
  //composition of target_data_source_name as _association_name
{
  key technician_id as TechnicianId,
      first_name    as FirstName,
      middle_name   as MiddleName,
      last_name     as LastName,
      contact_no    as ContactNo,
      address       as Address,
      country       as Country,
      email         as Email
      //    _association_name // Make association public
}
