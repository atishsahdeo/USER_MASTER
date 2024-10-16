*"* use this source file for your ABAP unit test classes
CLASS ltc_zuser_data DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    TYPES: BEGIN OF ty_user_data,
             user_id      TYPE zuser_data-user_id,
             first_name   TYPE zuser_data-first_name,
             last_name    TYPE zuser_data-last_name,
             email        TYPE zuser_data-email,
             phone_number TYPE zuser_data-phone_number,
             date_of_birth TYPE zuser_data-date_of_birth,
             creation_date TYPE zuser_data-creation_date,
             created_by   TYPE zuser_data-created_by,
           END OF ty_user_data.

    DATA: lt_user_data TYPE TABLE OF ty_user_data,
          ls_user_data TYPE ty_user_data.

    METHODS:
      setup,
      teardown,
      test_create_user FOR TESTING,
      test_read_user FOR TESTING,
      test_update_user FOR TESTING,
      test_delete_user FOR TESTING.
ENDCLASS.

CLASS ltc_zuser_data IMPLEMENTATION.
  METHOD setup.
    " Setup code here - Initialize test data
    CLEAR ls_user_data.
    ls_user_data-user_id = 'TEST_USER'.
    ls_user_data-first_name = 'John'.
    ls_user_data-last_name = 'Doe'.
    ls_user_data-email = 'john.doe@example.com'.
    ls_user_data-phone_number = '1234567890'.
    ls_user_data-date_of_birth = '19800101'.
    ls_user_data-creation_date = sy-datum.
    ls_user_data-created_by = sy-uname.
  ENDMETHOD.

  METHOD teardown.
    " Teardown code here - Clean up after test
    DELETE FROM zuser_data WHERE user_id = 'TEST_USER'.
  ENDMETHOD.

  METHOD test_create_user.
    DATA(lo_user_data) = NEW zcl_zuser_data( ).
    lo_user_data->create_user( i_user_data = ls_user_data ).

    SELECT SINGLE * FROM zuser_data INTO @ls_user_data WHERE user_id = @ls_user_data-user_id.
    cl_abap_unit_assert=>assert_not_initial( act = ls_user_data-user_id ).
  ENDMETHOD.

  METHOD test_read_user.
    DATA(lo_user_data) = NEW zcl_zuser_data( ).
    lo_user_data->create_user( i_user_data = ls_user_data ).

    DATA ls_read_user_data TYPE ty_user_data.
    lo_user_data->read_user(
      EXPORTING
        i_user_id   = ls_user_data-user_id
      IMPORTING
        e_user_data = ls_read_user_data ).

    cl_abap_unit_assert=>assert_equals( act = ls_read_user_data-first_name exp = 'John' ).
  ENDMETHOD.

  METHOD test_update_user.
    DATA(lo_user_data) = NEW zcl_zuser_data( ).
    lo_user_data->create_user( i_user_data = ls_user_data ).

    ls_user_data-first_name = 'Jane'.
    lo_user_data->update_user( i_user_data = ls_user_data ).

    SELECT SINGLE * FROM zuser_data INTO @ls_user_data WHERE user_id = @ls_user_data-user_id.
    cl_abap_unit_assert=>assert_equals( act = ls_user_data-first_name exp = 'Jane' ).
  ENDMETHOD.

  METHOD test_delete_user.
    DATA(lo_user_data) = NEW zcl_zuser_data( ).
    lo_user_data->create_user( i_user_data = ls_user_data ).

    lo_user_data->delete_user( i_user_id = ls_user_data-user_id ).

    SELECT SINGLE * FROM zuser_data INTO @ls_user_data WHERE user_id = @ls_user_data-user_id.
    cl_abap_unit_assert=>assert_initial( act = ls_user_data-user_id ).
  ENDMETHOD.
ENDCLASS.
