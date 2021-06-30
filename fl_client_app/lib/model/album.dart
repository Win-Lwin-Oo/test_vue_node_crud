class Album {
  final int userId;
  final int id;
  final String title;

  Album({required this.userId, required this.id, required this.title});

  //factory constructors, which can return subtypes or even null
  factory Album.fromJsonObj(Map<String, dynamic> json) {
    //print('JSON OBJ=>$json');
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  factory Album.fromJsonArr(dynamic json) {
    //print('JSON OBJ=>$json');
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{ ${this.userId}, ${this.id}, ${this.title} }';
  }
}