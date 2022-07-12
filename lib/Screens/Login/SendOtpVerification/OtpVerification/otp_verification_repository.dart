


import '../../../../api_base/api_base_helper.dart';
import 'otp_verification_model.dart';

class OtpVerificationRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<OtpVerificationModel> otpVerification(body) async{
    final response= await _apiBaseHelper.post("CusApi/Login/ValidateCustomerLoginForMobileApp", body);
    return OtpVerificationModel.fromJson(response);
  }

}