import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../api_base/api_response.dart';
import '../CreateSupportTicket/create_support_ticket_model.dart';
import 'create_support_ticket_repository.dart';


class CreateSupportTicketBloc {
  late CreateSupportTicketRepository  _setAddressRepository;

  late StreamController<ApiResponse<CreateSupportTicketModel>> _setAddressController;

  StreamSink<ApiResponse<CreateSupportTicketModel>>? get setAddressSink =>
      _setAddressController.sink;

  Stream<ApiResponse<CreateSupportTicketModel>>? get createSupportTicketStream =>
      _setAddressController.stream;


  CreateSupportTicketBloc() {
    _setAddressController = StreamController<ApiResponse<CreateSupportTicketModel>>.broadcast();
    _setAddressRepository = CreateSupportTicketRepository();
    // getOtp();
  }
  createSupportTicket(Map body) async {
    setAddressSink?.add(ApiResponse.loading("Fetching",));

    try {
      CreateSupportTicketModel response = await _setAddressRepository.createSupportTicket(body);
      setAddressSink?.add(ApiResponse.completed(response));
    } catch (e) {
      setAddressSink?.add(ApiResponse.error(e.toString()));
      if (kDebugMode) {
        print(e);
      }
    }
  }

}