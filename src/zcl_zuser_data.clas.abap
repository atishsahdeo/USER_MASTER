CLASS zcl_zuser_data DEFINITION PUBLIC.
  PUBLIC SECTION.
    TYPES: BEGIN OF ty_user_data,
             user_id       TYPE zuser_data-user_id,
             first_name    TYPE zuser_data-first_name,
             last_name     TYPE zuser_data-last_name,
             email         TYPE zuser_data-email,
             phone_number  TYPE zuser_data-phone_number,
             date_of_birth TYPE zuser_data-date_of_birth,
             creation_date TYPE zuser_data-creation_date,
             created_by    TYPE zuser_data-created_by,
           END OF ty_user_data.

    METHODS: create_user
      IMPORTING
        i_user_data TYPE ty_user_data.

    METHODS: read_user
      IMPORTING
        i_user_id TYPE zuser_data-user_id
      EXPORTING
        e_user_data TYPE ty_user_data.

    METHODS: update_user
      IMPORTING
        i_user_data TYPE ty_user_data.

    METHODS: delete_user
      IMPORTING
        i_user_id TYPE zuser_data-user_id.
ENDCLASS.

CLASS zcl_zuser_data IMPLEMENTATION.

  METHOD create_user.
    INSERT INTO zuser_data VALUES i_user_data.
    IF sy-subrc <> 0.
      " Handle error
    ENDIF.
  ENDMETHOD.

  METHOD read_user.
    SELECT SINGLE * FROM zuser_data INTO e_user_data WHERE user_id = i_user_id.
    IF sy-subrc <> 0.
      " Handle not found
    ENDIF.
  ENDMETHOD.

  METHOD update_user.
    UPDATE zuser_data SET
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
    DELETE FROM zuser_data WHERE user_id = i_user_id.
    IF sy-subrc <> 0.
      " Handle error
    ENDIF.
  ENDMETHOD.

ENDCLASS.

