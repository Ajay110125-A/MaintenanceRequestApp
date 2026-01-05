CLASS lhc__task DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS createTaskId FOR DETERMINE ON SAVE
      IMPORTING keys FOR _Task~createTaskId.
    METHODS setStatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR _Task~setStatus.

ENDCLASS.

CLASS lhc__task IMPLEMENTATION.

  METHOD createTaskId.

    DATA : l_max_taskid TYPE zaj_task_id.

    DATA : lt_modified_tasks TYPE TABLE FOR UPDATE zi_maintenance_task.

    READ ENTITIES OF zi_maintenance_req IN LOCAL MODE
      ENTITY _Task BY \_Main
      FIELDS ( RequestId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_requests).

    IF lt_requests IS NOT INITIAL.

       LOOP AT lt_requests ASSIGNING FIELD-SYMBOL(<fs_request>).

         READ ENTITIES OF zi_maintenance_req IN LOCAL MODE
           ENTITY _Main BY \_Task
           FIELDS ( TaskId )
           WITH VALUE #( ( %tky = <fs_request>-%tky ) )
           RESULT DATA(lt_tasks).

         LOOP AT lt_tasks ASSIGNING FIELD-SYMBOL(<fs_task>).

            l_max_taskid = COND #( WHEN <fs_task>-%data-TaskId > l_max_taskid
                                     THEN <fs_task>-%data-TaskId
                                   ELSE l_max_taskid
                                 ).
         ENDLOOP.

         LOOP AT lt_tasks ASSIGNING <fs_task> WHERE %data-TaskId IS INITIAL.

           l_max_taskid = l_max_taskid + 1.
           lt_modified_tasks = VALUE #( BASE lt_modified_tasks
                                        (
                                          %tky = <fs_task>-%tky
                                          %data-TaskId = l_max_taskid
                                        )
                                      ).

         ENDLOOP.

         MODIFY ENTITIES OF zi_maintenance_req IN LOCAL MODE
           ENTITY _Task
           UPDATE FIELDS ( TaskId )
           WITH CORRESPONDING #( lt_modified_tasks ).

       ENDLOOP.

    ENDIF.

  ENDMETHOD.

  METHOD setStatus.

    READ ENTITIES OF zi_maintenance_req IN LOCAL MODE
      ENTITY _Task BY \_Main
      FIELDS ( RequestId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_requests).



  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
