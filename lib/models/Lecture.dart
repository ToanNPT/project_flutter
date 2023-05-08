class Lecture {
  num id;
  num chapterId;
  String title;
  String description;
  String link;
  String owner;

  Lecture(
      {this.id,
      this.chapterId,
      this.title,
      this.description,
      this.link,
      this.owner});

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
        id: json["id"],
        chapterId: json["chapterId"],
        title: json["title"],
        description: json["description"],
        link: json["link"],
        owner: json["owner"]);
  }
}
