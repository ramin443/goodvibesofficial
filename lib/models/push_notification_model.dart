// {
// "click_action":"FLUTTER_NOTIFICATION_CLICK",
//  "type": "nav",
//  "data": {
//  "page_name" :"single_player",
//  "page_id" :"738",
// "id_name":"traclId",
//  "link": "some_external_link/store_url"
//  }
//  }


class PushNotifictionData {
  String pageName;
  String pageId;
  String idName;
  String link;
  String message;

  PushNotifictionData(
      {this.pageName, this.pageId, this.idName, this.link, this.message});

  factory PushNotifictionData.fromJson(Map<String, dynamic> json) =>
      PushNotifictionData(
          pageName: json["page_name"],
          pageId: json["page_id"],
          idName: json["id_name"],
          link: json["link"],
          message: json["message"]);
}
