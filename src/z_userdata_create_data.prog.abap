*&---------------------------------------------------------------------*
*& Report z_userdata_create_data
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_userdata_create_data.

DATA: lt_zuser_data TYPE TABLE OF zuser_data,
      ls_zuser_data TYPE zuser_data.

DO 10 TIMES.
  CLEAR ls_zuser_data.
  ls_zuser_data-user_id = |USER{ sy-index }|.
  ls_zuser_data-first_name = |FirstName{ sy-index }|.
  ls_zuser_data-last_name = |LastName{ sy-index }|.
  ls_zuser_data-email = |user{ sy-index }@example.com|.
  ls_zuser_data-phone_number = |1234567890|.
  ls_zuser_data-date_of_birth = '19900101'.
  ls_zuser_data-creation_date = sy-datum.
  ls_zuser_data-created_by = sy-uname.
  APPEND ls_zuser_data TO lt_zuser_data.
ENDDO.

INSERT zuser_data FROM TABLE lt_zuser_data.
IF sy-subrc = 0.
  WRITE: '10 records have been successfully inserted into zuser_data.'.
ELSE.
  WRITE: 'Error occurred while inserting records.'.
ENDIF.
