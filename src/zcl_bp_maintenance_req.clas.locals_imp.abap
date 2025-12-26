CLASS lhc__Main DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _Main RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _Main RESULT result.
    METHODS createRequestId FOR DETERMINE ON SAVE
      IMPORTING keys FOR _Main~createRequestId.

ENDCLASS.

CLASS lhc__Main IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD createRequestId.

*    READ ENTITIES OF zi_maintenance_req IN LOCAL MODE
*      ENTITY _Main
*      FIELDS



  ENDMETHOD.

ENDCLASS.
