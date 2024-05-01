class SocialUserModel
{
  String? name;
  String? email;
  String? phone;
  String? password;
  String? uId;
  String? image;
  String? bio;
  bool? isVerified;

  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.uId,
    this.image,
    this.bio,
    this.isVerified,
});

  SocialUserModel.fromJson(Map<String,dynamic>json)
  {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    isVerified = json['isVerified'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'bio':bio,
      'image':image,
      'password':password,
      'isVerified' : isVerified,
    };

  }

}