CLASS lhc__Main DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _Main RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _Main RESULT result.
    METHODS createRequestId FOR DETERMINE ON SAVE
      IMPORTING keys FOR _Main~createRequestId.
    METHODS AssignStatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR _Main~AssignStatus.
    METHODS setRequestDate FOR DETERMINE ON SAVE
      IMPORTING keys FOR _Main~setRequestDate.
    METHODS checkEquipment FOR VALIDATE ON SAVE
      IMPORTING keys FOR _Main~checkEquipment.
    METHODS checkSite FOR VALIDATE ON SAVE
      IMPORTING keys FOR _Main~checkSite.

ENDCLASS.

CLASS lhc__Main IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.

    result = VALUE #( %create = if_abap_behv=>auth-allowed ).

  ENDMETHOD.

  METHOD createRequestId.

    READ ENTITIES OF zi_maintenance_req IN LOCAL MODE
      ENTITY _Main
      FIELDS ( RequestId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_requests).

    DELETE lt_requests WHERE %data-RequestId IS NOT INITIAL.

    IF lt_requests IS NOT INITIAL.

      SELECT SINGLE
        FROM zaj_maint_req
        FIELDS request_id
        INTO @DATA(l_latest_reqid).

      MODIFY ENTITIES OF zi_maintenance_req IN LOCAL MODE
        ENTITY _Main
        UPDATE FIELDS ( RequestId )
        WITH VALUE #(
                      FOR lwa_reqid IN lt_requests INDEX INTO l_index
                      (
                        %tky = lwa_reqid-%tky
                        %data-RequestId = l_latest_reqid + l_index
                      )
                    ).

    ENDIF.

  ENDMETHOD.

  METHOD AssignStatus.

    READ ENTITIES OF zi_maintenance_req IN LOCAL MODE
      ENTITY _Main
      FIELDS ( StatusId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_requests).

    DELETE lt_requests WHERE %data-StatusId IS NOT INITIAL.

    IF lt_requests IS NOT INITIAL.

      MODIFY ENTITIES OF zi_maintenance_req IN LOCAL MODE
        ENTITY _Main
        UPDATE FIELDS ( StatusId )
        WITH VALUE #( FOR lwa_request IN lt_requests
                       (
                         %tky = lwa_request-%tky
                         %data-StatusId = 'N'
                       )
                    ).

    ENDIF.

  ENDMETHOD.

  METHOD setRequestDate.

    READ ENTITIES OF zi_maintenance_req IN LOCAL MODE
      ENTITY _Main
      FIELDS ( RequestedDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_requests).

    DELETE lt_requests WHERE %data-RequestedDate IS NOT INITIAL.

    IF lt_requests IS NOT INITIAL.

      MODIFY ENTITIES OF zi_maintenance_req IN LOCAL MODE
        ENTITY _Main
        UPDATE FIELDS ( RequestedDate )
        WITH VALUE #(
                      FOR lwa_request IN lt_requests
                      (
                        %tky = lwa_request-%tky
                        %data-RequestedDate = cl_abap_context_info=>get_system_date( )
                      )
                    ).

    ENDIF.

  ENDMETHOD.

  METHOD checkEquipment.

    READ ENTITIES OF zi_maintenance_req IN LOCAL MODE
      ENTITY _Main
      FIELDS ( EquipmentId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_requests).

    DELETE lt_requests WHERE %data-EquipmentId IS INITIAL.

    IF lt_requests IS INITIAL.

      SELECT
        FROM zaj_euip_details
        FIELDS equipmentid
        FOR ALL ENTRIES IN @lt_requests
        WHERE equipmentid = @lt_requests-%data-EquipmentId
        INTO TABLE @DATA(lt_euip_details).
      IF sy-subrc EQ 0.

        LOOP AT lt_requests ASSIGNING FIELD-SYMBOL(<fs_request>).

          reported-_main = VALUE #( BASE reported-_main
                                    (
                                      %tky = <fs_request>-%tky
                                      %state_area = 'VALID_EQUIPMENT'
                                    )
                                  ).

          IF <fs_request>-%data-EquipmentId IS INITIAL.

            failed-_main = VALUE #( BASE failed-_main
                                    ( %tky = <fs_request>-%tky )
                                  ).
            reported-_main = VALUE #( BASE reported-_main
                                      (
                                        %tky = <fs_request>-%tky
                                        %state_area = 'VALID_EQUIPMENT'
                                        %msg = new_message(
                                                 id       = 'ZAJ_MESSAGE_POOL'
                                                 number   = 002
                                                 severity = if_abap_behv_message=>severity-error
                                               )
                                      )
                                    ).



          ELSEIF NOT line_exists( lt_euip_details[ equipmentid = <fs_request>-%data-EquipmentId ] ).

            failed-_main = VALUE #( BASE failed-_main
                                    ( %tky = <fs_request>-%tky )
                                  ).

            reported-_main = VALUE #( BASE reported-_main
                                     (
                                        %tky = <fs_request>-%tky
                                        %state_area = 'VALID_EQUIPMENT'
                                        %msg = new_message(
                                                 id       = 'ZAJ_MESSAGE_POOL'
                                                 number   = 001
                                                 severity = if_abap_behv_message=>severity-error
                                                 v1       = <fs_request>-%data-EquipmentId
                                               )
                                       %element-equipmentid = if_abap_behv=>mk-on
                                     )
                                    ).


          ENDIF.

        ENDLOOP.

      ENDIF.

    ENDIF.

  ENDMETHOD.

  METHOD checkSite.

    READ ENTITIES OF zi_maintenance_req IN LOCAL MODE
      ENTITY _Main
      FIELDS ( SiteId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_requests).

    DELETE lt_requests WHERE %data-SiteId IS INITIAL.

    LOOP AT lt_requests ASSIGNING FIELD-SYMBOL(<fs_requests>).

      SELECT
        FROM zaj_site_info
        FIELDS site_id
        FOR ALL ENTRIES IN @lt_requests
        WHERE site_id = @lt_requests-%data-SiteId
        INTO TABLE @DATA(lt_site_info).
      IF sy-subrc EQ 0.



      ENDIF.

    ENDLOOP.



  ENDMETHOD.

ENDCLASS.
