import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:topmaybe/Screens/CartPage/SetCart/setcart_model.dart';
import '../../../api_base/api_response.dart';
import 'SetCartRepository.dart';


class SetCartBloc {
  late SetCartRepository  _setCartRepository;

  late StreamController<ApiResponse<SetCartModel>> _getOtpController;

  StreamSink<ApiResponse<SetCartModel>>? get setCartSink =>
      _getOtpController.sink;

  Stream<ApiResponse<SetCartModel>>? get setCartStream =>
      _getOtpController.stream;


  SetCartBloc() {
    _getOtpController = StreamController<ApiResponse<SetCartModel>>.broadcast();
    _setCartRepository = SetCartRepository();
    // getOtp();
  }
  setCart(Map body) async {
    setCartSink?.add(ApiResponse.loading("Fetching",));

    try {
      SetCartModel response = await _setCartRepository.setCart(body);
      setCartSink?.add(ApiResponse.completed(response));
    } catch (e) {
      setCartSink?.add(ApiResponse.error(e.toString()));
      if (kDebugMode) {
        print(e);
      }
    }
  }

}