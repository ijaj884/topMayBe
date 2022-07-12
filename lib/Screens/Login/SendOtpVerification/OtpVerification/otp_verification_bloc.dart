import 'dart:async';

import '../../../../api_base/api_response.dart';
import 'otp_verification_model.dart';
import 'otp_verification_repository.dart';
import 'package:flutter/foundation.dart';



class OtpVerificationBloc {
  late OtpVerificationRepository  _getOtpRepository;

  late StreamController<ApiResponse<OtpVerificationModel>> _getOtpController;

  StreamSink<ApiResponse<OtpVerificationModel>>? get getOtpSink =>
      _getOtpController.sink;

  Stream<ApiResponse<OtpVerificationModel>>? get otpVerificationStream =>
      _getOtpController.stream;


  OtpVerificationBloc() {
    _getOtpController = StreamController<ApiResponse<OtpVerificationModel>>.broadcast();
    _getOtpRepository = OtpVerificationRepository();
    // getOtp();
  }
  otpVerification(Map body) async {
    getOtpSink?.add(ApiResponse.loading("Fetching",));

    try {
      OtpVerificationModel response = await _getOtpRepository.otpVerification(body);
      getOtpSink?.add(ApiResponse.completed(response));
    } catch (e) {
      getOtpSink?.add(ApiResponse.error(e.toString()));
      if (kDebugMode) {
        print(e);
      }
    }
  }

}