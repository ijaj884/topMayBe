import '../../../api_base/api_base_helper.dart';
import '../CreateSupportTicket/create_support_ticket_model.dart';



class AddReplySupportTicketRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<CreateSupportTicketModel> addReplySupportTicket(body) async{
    Map body={
      "stktd_stkth_id": 1,
      "stktd_message": "reply message",
      "stktd_cus_id": 1
    };
    final response= await _apiBaseHelper.post("api/SupportTicket/AddReply", body);
    return CreateSupportTicketModel.fromJson(response);
  }
}
