import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../api_base/api_response.dart';
import '../CreateSupportTicket/create_support_ticket_model.dart';
import 'add_reply_support_ticket.dart';


class AddReplySupportTicketBloc {
  late AddReplySupportTicketRepository  _setAddressRepository;

  late StreamController<ApiResponse<CreateSupportTicketModel>> _setAddressController;

  StreamSink<ApiResponse<CreateSupportTicketModel>>? get setAddressSink =>
      _setAddressController.sink;

  Stream<ApiResponse<CreateSupportTicketModel>>? get addReplySupportTicketStream =>
      _setAddressController.stream;


  AddReplySupportTicketBloc() {
    _setAddressController = StreamController<ApiResponse<CreateSupportTicketModel>>.broadcast();
    _setAddressRepository = AddReplySupportTicketRepository();
    // getOtp();
  }
  addReplySupportTicket(Map body) async {
    setAddressSink?.add(ApiResponse.loading("Fetching",));

    try {
      CreateSupportTicketModel response = await _setAddressRepository.addReplySupportTicket(body);
      setAddressSink?.add(ApiResponse.completed(response));
    } catch (e) {
      setAddressSink?.add(ApiResponse.error(e.toString()));
      if (kDebugMode) {
        print(e);
      }
    }
  }

}