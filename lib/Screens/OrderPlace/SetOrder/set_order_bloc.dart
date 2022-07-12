import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:topmaybe/Screens/OrderPlace/SetOrder/set_order_model.dart';
import 'package:topmaybe/Screens/OrderPlace/SetOrder/set_order_repository.dart';
import '../../../api_base/api_response.dart';

class SetOrderBloc {
  late SetOderRepository  _setOrderRepository;

  late StreamController<ApiResponse<SetOrderModel>> _setOrderController;

  StreamSink<ApiResponse<SetOrderModel>>? get setOrderSink =>
      _setOrderController.sink;

  Stream<ApiResponse<SetOrderModel>>? get setOrderStream =>
      _setOrderController.stream;


  SetOrderBloc() {
    _setOrderController = StreamController<ApiResponse<SetOrderModel>>.broadcast();
    _setOrderRepository = SetOderRepository();
    // getOtp();
  }
  orderPlaced(Map body) async {
    setOrderSink?.add(ApiResponse.loading("Fetching",));

    try {
      SetOrderModel response = await _setOrderRepository.setOrder(body);
      setOrderSink?.add(ApiResponse.completed(response));
    } catch (e) {
      setOrderSink?.add(ApiResponse.error(e.toString()));
      if (kDebugMode) {
        print(e);
      }
    }
  }

}