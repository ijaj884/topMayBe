import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:topmaybe/Screens/MyAddress/AddNewAddress/set_address_model.dart';
import 'package:topmaybe/Screens/MyAddress/AddNewAddress/set_address_repository.dart';
import '../../../api_base/api_response.dart';


class SetAddressBloc {
  late SetAddressRepository  _setAddressRepository;

  late StreamController<ApiResponse<SetAddressModel>> _setAddressController;

  StreamSink<ApiResponse<SetAddressModel>>? get setAddressSink =>
      _setAddressController.sink;

  Stream<ApiResponse<SetAddressModel>>? get setAddressStream =>
      _setAddressController.stream;


  SetAddressBloc() {
    _setAddressController = StreamController<ApiResponse<SetAddressModel>>.broadcast();
    _setAddressRepository = SetAddressRepository();
    // getOtp();
  }
  setAddress(Map body) async {
    setAddressSink?.add(ApiResponse.loading("Fetching",));

    try {
      SetAddressModel response = await _setAddressRepository.setAddress(body);
      setAddressSink?.add(ApiResponse.completed(response));
    } catch (e) {
      setAddressSink?.add(ApiResponse.error(e.toString()));
      if (kDebugMode) {
        print(e);
      }
    }
  }

}