class Contact {
  int? _id;
  String? _name;
  String? _phone;
  String? _imgUrl;

  Contact(dynamic obj) {
    _id = obj['id'];
    _name = obj['name'];
    _phone = obj['phone'];
    _imgUrl = obj['imgUrl'];
  }

  toMap(){
    var Map={
      'id':_id,
      'name': _name,
      'phone': _phone,
      'imgUrl': _imgUrl,
    };
    return Map;

  }
    Contact.fromMap(Map map)
    {
      _id= map['id'];
      _name = map['name'];
      _phone =map ['phone'];
      _imgUrl = map['imgUrl'];
    }
    get id =>_id;
  get name =>_name;
  get phone =>_phone;
  get imgUrl =>_imgUrl;

}