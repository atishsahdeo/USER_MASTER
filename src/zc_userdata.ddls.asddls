@AbapCatalog.sqlViewName: 'ZUSRMV'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'User Master Data'
define view ZC_UserData as select from zuser_data {
  key user_id,
  first_name,
  last_name,
  email,
  phone_number,
  date_of_birth,
  creation_date,
  created_by
}
