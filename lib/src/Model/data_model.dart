class DataModel{
  int ? id;
  String?title;
  String? dueDate;
  String ?categories;

  DataModel({this.title,this.id,this.categories,this.dueDate});

  DataModel.fromMap(Map<String,dynamic>data):
      id=data['id'],
      title=data['title'],
      dueDate=data['dueDate'],
      categories=data['categories'];
  Map<String, Object?> toMap(){
    return{
      "id":id,
      "title":title,
      "dueDate":dueDate,
      "categories":categories,
    };
  }
}