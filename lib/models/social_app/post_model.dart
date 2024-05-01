class SocialPostModel
{
  String? name;
  String? uId;
  String? image;
  String? date;
  String? postImage;
  String? text;

  SocialPostModel({
    this.name,
    this.uId,
    this.image,
    this.date,
    this.text,
    this .postImage
  });

  SocialPostModel.fromJson(Map<String,dynamic>json)
  {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    date = json['date'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'name':name,
      'uId':uId,
      'image':image,
      'date':date,
      'text':text,
      'postImage':postImage
    };

  }

}