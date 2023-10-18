/// _id : "6486fb69a961d6c460d6aede"
/// title : "cdbdb"
/// description : "dgsbsgendtdb du dndfrrfrrhbdht"

class NotesModel {
  NotesModel({
      String? id, 
      String? title, 
      String? description,}){
    _id = id;
    _title = title;
    _description = description;
}

  NotesModel.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _description = json['description'];
  }
  String? _id;
  String? _title;
  String? _description;
NotesModel copyWith({  String? id,
  String? title,
  String? description,
}) => NotesModel(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    return map;
  }

}