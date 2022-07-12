import '../../../api_base/api_base_helper.dart';
import 'create_support_ticket_model.dart';



class CreateSupportTicketRepository{
  final ApiBaseHelper _apiBaseHelper =  ApiBaseHelper();

  Future<CreateSupportTicketModel> createSupportTicket(body) async{
    Map body={
      "stkth_cus_id": 1,
      "stkth_spriority_id": 1,
      "stkth_sttyp_id": 1,
      "stkth_subject": "support subject",
      "stkth_message": "support message"
    };
    final response= await _apiBaseHelper.post("api/SupportTicket/Create", body);
    return CreateSupportTicketModel.fromJson(response);
  }
}
