
class AppConstant{

  static String server_address = 'http://placeyourservicewebapi-dev.ap-south-1.elasticbeanstalk.com/';
  static int networkTimeOut = 60;

  static bool is_debug_logs_on = true;
  static bool is_info_logs_on = true;
  static bool is_exception_logs_on = true;


  //Master Api Call
  static String GET_MASTER_DATA_BY_NAME = server_address + "api/MasterData/GetMasterDataByName";

  //API CAll
  static String LOGIN_AUTH = server_address + "api/Login/Login";
  static String FORGOT_PASSWORD = server_address + "api/Login/ForgetPassword";
  static String GET_PASSWORD = server_address + "api/Login/GetPassword";
  static String USER_DETAILS = server_address + "api/User/CurrentUser";
  static String GET_TECHNICIAN = server_address + "api/Technician/GetTechnician";

  //User Details

  static String userTokken ='';
}