import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../api_base/api_response.dart';
import 'delete_address_model.dart';
import 'delete_address_repository.dart';


class DeleteAddressBloc {
  late DeleteAddressRepository  _setAddressRepository;

  late StreamController<ApiResponse<DeleteAddressModel>> _setAddressController;

  StreamSink<ApiResponse<DeleteAddressModel>>? get setAddressSink =>
      _setAddressController.sink;

  Stream<ApiResponse<DeleteAddressModel>>? get deleteAddressStream =>
      _setAddressController.stream;


  DeleteAddressBloc() {
    _setAddressController = StreamController<ApiResponse<DeleteAddressModel>>.broadcast();
    _setAddressRepository = DeleteAddressRepository();
    // getOtp();
  }
  deleteAddress(String caddId) async {
    setAddressSink?.add(ApiResponse.loading("Fetching",));

    try {
      DeleteAddressModel response = await _setAddressRepository.deleteAddress(caddId);
      setAddressSink?.add(ApiResponse.completed(response));
    } catch (e) {
      setAddressSink?.add(ApiResponse.error(e.toString()));
      if (kDebugMode) {
        print(e);
      }
    }
  }

}