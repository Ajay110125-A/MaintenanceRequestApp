@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection of Maintenance Task'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZC_MAINTENANCE_TASK
  as projection on ZI_MAINTENANCE_TASK
{
  key TaskUUId,
      RequestUUId,
      TaskId,

      ScheduleStart,
      ScheduleEnd,

      ActualStart,
      ActualEnd,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #LOW
      @ObjectModel.text.element: [ 'TechnicianName' ]
      @Consumption.valueHelpDefinition: [{ entity: {
                                                     name: 'ZI_TECH_INFO_AY',
                                                     element: 'TechnicianId'
                                                    },
                                            useForValidation: true
                                        }]
      TechnicianId,
      _Tech.FirstName       as TechnicianName,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      EstimatedCost,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      ActualCost,
      
      @Consumption.valueHelpDefinition: [{
                                            entity: {
                                                      name: 'I_CurrencyStdVH',
                                                      element: 'Currency'
                                                    },
                                            useForValidation: true
                                        }]
      CurrencyCode,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Search.ranking: #HIGH
      @ObjectModel.text.element: [ 'Status' ]
      TaskStatus,
      _Status.StatusName    as Status,

      TechNote,

      LocalLastChangedAt,
      /* Associations */
      _Main : redirected to parent ZC_MAINTENANCE_REQ,
      _Status,
      _Tech
}
