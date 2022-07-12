import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:topmaybe/Screens/Login/SendOtpVerification/send_otp_model.dart';
import 'package:topmaybe/Screens/Login/SendOtpVerification/send_otp_repository.dart';

import '../../../api_base/api_response.dart';


class GetOtpBloc {
  late GetOtpRepository  _getOtpRepository;

  late StreamController<ApiResponse<SendOtpModel>> _getOtpController;

  StreamSink<ApiResponse<SendOtpModel>>? get getOtpSink =>
      _getOtpController.sink;

  Stream<ApiResponse<SendOtpModel>>? get getOtpStream =>
      _getOtpController.stream;


  GetOtpBloc() {
    _getOtpController = StreamController<ApiResponse<SendOtpModel>>.broadcast();
    _getOtpRepository = GetOtpRepository();
    // getOtp();
  }
  getOtp(Map body) async {
    getOtpSink?.add(ApiResponse.loading("Fetching",));

    try {
      SendOtpModel response = await _getOtpRepository.getOtp(body);
      getOtpSink?.add(ApiResponse.completed(response));
    } catch (e) {
      getOtpSink?.add(ApiResponse.error(e.toString()));
      if (kDebugMode) {
        print(e);
      }
    }
  }

}