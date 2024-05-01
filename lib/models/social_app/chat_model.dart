
class SocialChatModel
{
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  String? image;

  SocialChatModel({
    this.text,
    this.receiverId,
    this.dateTime,
    this.senderId,
    this.image,
  });

  SocialChatModel.fromJson(Map<String,dynamic>json)
  {
    text = json['text'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    image = json['image'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'text':text,
      'receiverId':receiverId,
      'senderId':senderId,
      'dateTime':dateTime,
      'image':image
    };

  }

}