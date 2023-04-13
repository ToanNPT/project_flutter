class ReviewModel {
  String id;
  String username;
  String courseId;
  String content;
  double rate;
  String createDate;
  String updateDate;


  ReviewModel(
      {this.id,
        this.username,
        this.courseId,
        this.content,
        this.rate,
        this.createDate,
        this.updateDate,
      });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
        id: json["id"],
        username: json["username"],
        //category: json["category.name"],
        courseId: json["language"],
        content: json["content"],
        rate: json["rate"],
        createDate: json["createDate"],
        updateDate: json["updateDate"]);
  }
}
