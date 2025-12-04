@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection of Maintenance Req'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true

define root view entity ZC_MAINTENANCE_REQ
  provider contract transactional_query
  as projection on ZI_MAINTENANCE_REQ
{

  key RequestUUId,
  
      RequestId,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #HIGH
      @ObjectModel.text.element: [ 'EquipmentName' ]
      @Consumption.valueHelpDefinition: [
                                          { entity: {
                                                      name: 'ZI_EQUIP_DETAILS',
                                                      element: 'EquipmentId'
                                                    } 
                                           }
                                         ]
      EquipmentId,
      EquipmentName,
      
      
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #HIGH
      @ObjectModel.text.element: [ 'Site' ]
      @Consumption.valueHelpDefinition: [
                                          { entity: {
                                                      name: 'ZI_SITE_INFO_AY',
                                                      element: 'SiteId'
                                                    } 
                                           }
                                         ]
      SiteId,
      Site,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #MEDIUM
      @ObjectModel.text.element: [ 'Priority' ]
      @Consumption.valueHelpDefinition: [
                                          { entity: {
                                                      name: 'ZI_PRIORITY_INFO_AY',
                                                      element: 'PriorityId'
                                                    } 
                                           }
                                         ]
      PriorityId,
      Priority,

      Description,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #MEDIUM
      @ObjectModel.text.element: [ 'Status' ]
      @Consumption.valueHelpDefinition: [
                                          { entity: {
                                                      name: 'ZI_STATUS_INFO_AY',
                                                      element: 'StatusId'
                                                    } 
                                           }
                                         ]
      StatusId,
      Status,

      RequestedDate,
      //      LocalCreatedBy,
      //      LocalCreatedAt,
      //      LocalLastChangedBy,
      //      LocalLastChangedAt,
      //      LastChangedAt,
      /* Associations */
      _Equip,
      _Priority,
      _Site,
      _Status,
      _Task : redirected to composition child ZC_MAINTENANCE_TASK
}
