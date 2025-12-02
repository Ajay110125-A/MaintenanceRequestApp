@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Site Information'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SITE_INFO_AY
  as select from zaj_site_info
  //composition of target_data_source_name as _association_name
{
  key site_id as SiteId,
      name    as SiteName
      //    _association_name // Make association public
}
