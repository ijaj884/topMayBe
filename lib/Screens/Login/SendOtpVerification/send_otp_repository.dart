

import 'package:topmaybe/Screens/Login/SendOtpVerification/send_otp_model.dart';

import '../../../api_base/api_base_helper.dart';

class GetOtpRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<SendOtpModel> getOtp(body) async{
    final response= await _apiBaseHelper.post("CusApi/Login/GetCustomerOTPForMobileApp", body);
    return SendOtpModel.fromJson(response);
  }

}