CLASS zcl_insert_main_ay DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_insert_main_ay IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA : lt_status TYPE TABLE OF zaj_status_ay,
           lt_tech_info TYPE TABLE OF zaj_tech_info,
           lt_site_info TYPE TABLE OF zaj_site_info,
           lt_priority TYPE TABLE OF zaj_priority_ay,
           lt_equip_details TYPE TABLE OF zaj_euip_details,
           lt_maint_req TYPE TABLE OF zaj_maint_req,
           lt_maint_task TYPE TABLE OF zaj_maint_tsk.


    lt_status = VALUE #(
                         ( status_id = 'I' status_name = 'In Progress' )
                         ( status_id = 'C' status_name = 'Completed' )
                         ( status_id = 'N' status_name = 'New' )
                         ( status_id = 'D' status_name = 'Dropped' )
                       ).

    DELETE zaj_status_ay FROM TABLE @lt_status.
    INSERT zaj_status_ay FROM TABLE @lt_status.


    lt_tech_info = VALUE #(
                           ( technician_id = 'TCHYD0000001' first_name = 'Bruce' middle_name = 'Mendan' last_name = 'Simmer'
                             contact_no = '2351453445' address = 'Something' country = 'IND' email = 'bruce.M,Simmer@mainte.com'  )
                           ( technician_id = 'TCHYD0000002' first_name = 'Kim' middle_name = 'Meridan' last_name = 'Simmer'
                             contact_no = '2351453445' address = 'Something' country = 'IND' email = 'bruce.M,Simmer@mainte.com'  )
                           ( technician_id = 'TCHYD0000003' first_name = 'Lance' middle_name = 'Simer' last_name = 'Simmer'
                             contact_no = '2351453445' address = 'Something' country = 'IND' email = 'bruce.M,Simmer@mainte.com'  )
                          ).

    DELETE zaj_tech_info FROM TABLE @lt_tech_info.
    INSERT zaj_tech_info FROM TABLE @lt_tech_info.

    lt_site_info = VALUE #(
                            ( site_id = 'MUMB' name = 'Mumbai' )
                            ( site_id = 'HYDB' name = 'Hyderabad' )
                            ( site_id = 'DELH' name = 'New Delhi' )
                            ( site_id = 'KOLT' name = 'Kolkata' )
                          ).

    DELETE zaj_site_info FROM TABLE @lt_site_info.
    INSERT zaj_site_info FROM TABLE @lt_site_info.

    lt_priority = VALUE #(
                           ( priority_id = 'H'  priority_name = 'High' )
                           ( priority_id = 'M'  priority_name = 'Medium' )
                           ( priority_id = 'L'  priority_name = 'Lower' )
                         ).

    DELETE zaj_priority_ay FROM TABLE @lt_priority.
    INSERT zaj_priority_ay FROM TABLE @lt_priority.

    lt_equip_details = VALUE #(
                                (
                                  equipmentid = 'EQUIPINDHYD0000001'
                                  equip_name = 'Semantic Analyzer'
                                  model_no = 'MODLAB00001234'
                                  manufacturer = 'Simmer Inc. LTD.'
                                  serial_no = '5CD206123456'
                                  installation_date = '20200815'
                                  warrant_end_date = '20320815'
                                )
                              ).

    DELETE zaj_euip_details FROM TABLE @lt_equip_details.
    INSERT zaj_euip_details FROM TABLE @lt_equip_details.

    TRY.
        lt_maint_req = VALUE #(
                               (
                                 request_uuid = cl_system_uuid=>create_uuid_x16_static( )
                                 request_id = '0000000001'
                                 equipmentid = 'EQUIPINDHYD0000001'
                                 siteid = 'HYDB'
                                 priority = 'M'
                                 description = 'Regular Maintenacen required'
                                 status = 'N'
                                 requested_date = cl_abap_context_info=>get_system_date( )
                                 local_created_by = cl_abap_context_info=>get_user_technical_name( )
                                 local_created_at = cl_abap_context_info=>get_system_date( ) - 15
                                 local_last_changed_by = ''
                                 local_last_changed_at = ''
                                 last_changed_at = cl_abap_context_info=>get_system_date( ) && cl_abap_context_info=>get_system_time( )
                               )
                              ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.

    INSERT zaj_maint_req FROM TABLE @lt_maint_req.

    DATA : l_schedule_date TYPE zaj_schedule_s.
    l_schedule_date = cl_abap_context_info=>get_system_date( ) - 12.
*    l_schedule_date = l_schedule_date  && cl_abap_context_info=>get_system_time( ).
    TRY.
        lt_maint_task = VALUE #(
                                 (
                                   task_uuid = cl_system_uuid=>create_uuid_x16_static( )
                                   request_uuid = lt_maint_req[ 1 ]-request_uuid
                                  task_id = '0000000001'
                                  schedule_start = l_schedule_date
                                  schedule_end   = cl_abap_context_info=>get_system_date( )
*                                actual_start
*                                actual_end
                                  techinician_id  = 'TCHYD0000002'
                                  estimated_cost = '12000'
*                                actual_cost
                                  currency_code = 'INR'
                                  task_status = 'N'
*                                notes
                                  local_last_changed_at = cl_abap_context_info=>get_system_date( ) && cl_abap_context_info=>get_system_time( )
                                 )
                               ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.

    INSERT zaj_maint_tsk FROM TABLE @lt_maint_task.

    out->write( 'Data Inserted in Tables' ).




  ENDMETHOD.
ENDCLASS.
