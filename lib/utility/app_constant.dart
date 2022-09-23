
class AppConstant{

  static bool isLive =false;
  static String live_server_address = '';
  static String uat_server_address = 'https://dev.placeyourservice.com/';
  static String server_address = isLive ?live_server_address:uat_server_address;
  static int networkTimeOut = 60;

  static bool is_debug_logs_on = true;
  static bool is_info_logs_on = true;
  static bool is_exception_logs_on = true;


  //Master Api Call
  static String GET_MASTER_DATA_BY_NAME = server_address + "api/MasterData/GetMasterDataByName";
  static String GET_MASTER_DATA_PINCODE = server_address + "api/MasterData/SearchPincode";

  //API CAll
  static String LOGIN_AUTH = server_address + "api/Login/Login";
  static String FORGOT_PASSWORD = server_address + "api/Login/ForgetPassword";
  static String GET_PASSWORD = server_address + "api/Login/GetPassword";
  static String USER_DETAILS = server_address + "api/User/CurrentUser";
  static String GET_TECHNICIAN = server_address + "api/Technician/GetTechnician";

  //User Details

  //Service Details
  static String GET_SERVICE_REQUEST = server_address + "api/ServiceRequest/GetServiceRequestsForTechnician";
  static String UPDATE_SERVICE_REQUEST = server_address + "api/ServiceRequest/UpdateServiceRequestStatus";

  static String userTokken ='';
}