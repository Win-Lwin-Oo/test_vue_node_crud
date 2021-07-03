class Tutorial {
  final int id;
  final String title;
  final String description;
  final bool published;
  final String createdAt;
  final String updatedAt;

  Tutorial(
      {required this.id,
      required this.title,
      required this.description,
      required this.published,
      required this.createdAt,
      required this.updatedAt});

  factory Tutorial.fromJsonObj(Map<String, dynamic> json) {
    return Tutorial(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        published: json['published'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }

  factory Tutorial.fromJsonArr(dynamic json) {
    return Tutorial(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        published: json['published'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.title}, ${this.description}, ${this.published}, ${this.createdAt}, ${this.updatedAt} }';
  }
}

class Result {
  final String status;
  final String message;

  Result({required this.status, required this.message});

  factory Result.fromJsonObj(Map<String, dynamic> json) {
    return Result(
        status: json['status'], message: json['message']);
  }

  @override
  String toString() {
    return '{ ${this.status}, ${this.message}';
  }
}
