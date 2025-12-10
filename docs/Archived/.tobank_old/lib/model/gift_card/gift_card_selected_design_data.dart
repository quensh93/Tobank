import 'package:universal_io/io.dart';

import 'response/list_event_plan_data.dart';
import 'response/list_message_gift_card_data.dart';

class GiftCardSelectedDesignData {
  Plan? selectedPlan;
  Event? selectedEvent;
  MessageData? selectedMessageData;
  String? cardTitle;
  String? customImageBase64;
  File? customImageFile;
}
