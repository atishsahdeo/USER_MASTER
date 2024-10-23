CLASS zcl_zuser_data DEFINITION PUBLIC.
  PUBLIC SECTION.
    TYPES: BEGIN OF ty_user_data,
             user_id       TYPE zas_user_data-user_id,
             first_name    TYPE zas_user_data-first_name,
             last_name     TYPE zas_user_data-last_name,
             email         TYPE zas_user_data-email,
             phone_number  TYPE zas_user_data-phone_number,
             date_of_birth TYPE zas_user_data-date_of_birth,
             creation_date TYPE zas_user_data-creation_date,
             created_by    TYPE zas_user_data-created_by,
           END OF ty_user_data.

    METHODS: create_user
      IMPORTING
        i_user_data TYPE ty_user_data.

    METHODS: read_user
      IMPORTING
        i_user_id TYPE zas_user_data-user_id
      EXPORTING
        e_user_data TYPE ty_user_data.

    METHODS: update_user
      IMPORTING
        i_user_data TYPE ty_user_data.

    METHODS: delete_user
      IMPORTING
        i_user_id TYPE zas_user_data-user_id.
ENDCLASS.

CLASS zcl_zuser_data IMPLEMENTATION.

  METHOD create_user.
    INSERT INTO zas_user_data VALUES @i_user_data.
    IF sy-subrc <> 0.
      " Handle error
    ENDIF.
  ENDMETHOD.

  METHOD read_user.
    SELECT SINGLE * FROM zas_user_data WHERE user_id = @i_user_id INTO @e_user_data.
    IF sy-subrc <> 0.
      " Handle not found
    ENDIF.
  ENDMETHOD.

  METHOD update_user.
    UPDATE zas_user_data SET
      first_name    = @i_user_data-first_name,
      last_name     = @i_user_data-last_name,
      email         = @i_user_data-email,
      phone_number  = @i_user_data-phone_number,
      date_of_birth = @i_user_data-date_of_birth,
      creation_date = @i_user_data-creation_date,
      created_by    = @i_user_data-created_by
    WHERE user_id = @i_user_data-user_id.
    IF sy-subrc <> 0.
      " Handle error
    ENDIF.
  ENDMETHOD.

  METHOD delete_user.
    DELETE FROM zas_user_data WHERE user_id = @i_user_id.
    IF sy-subrc <> 0.
      " Handle error
    ENDIF.
  ENDMETHOD.

ENDCLASS.

