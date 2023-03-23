class Course {
  String id;
  bool isActive;
  String category;
  String language;
  String name;
  String description;
  String accountName;
  double price;
  String createDate;
  String updateDate;
  int numStudents;
  bool isPublic;
  String avatar;
  double rate;
  int status;

  Course(
      {this.id,
      this.isActive,
      this.category,
      this.language,
      this.name,
      this.description,
      this.accountName,
      this.price,
      this.createDate,
      this.updateDate,
      this.numStudents,
      this.isPublic,
      this.avatar,
      this.rate,
      this.status});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        id: json["id"],
        isActive: json["isActive"],
        //category: json["category.name"],
        language: json["language"],
        name: json["name"],
        description: json["description"],
        accountName: json["accountName"],
        price: json["price"],
        createDate: json["createDate"],
        updateDate: json["updateDate"],
        numStudents: json["numStudents"],
        isPublic: json["isPublic"],
        avatar: json["avatar"],
        rate: json["rate"],
        status: json["status"]);
  }
}
