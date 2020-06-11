class News {
  String uniquekey;
  String title;
  String date;
  String category;
  String authorName;
  String url;
  String thumbnailPicS;
  String thumbnailPicS02;
  String thumbnailPicS03;

  News(
      {this.uniquekey,
      this.title,
      this.date,
      this.category,
      this.authorName,
      this.url,
      this.thumbnailPicS,
      this.thumbnailPicS02,
      this.thumbnailPicS03});

  News.fromJson(Map<String, dynamic> json) {
    uniquekey = json['uniquekey'];
    title = json['title'];
    date = json['date'];
    category = json['category'];
    authorName = json['author_name'];
    url = json['url'];
    thumbnailPicS = json['thumbnail_pic_s'];
    thumbnailPicS02 = json['thumbnail_pic_s02'];
    thumbnailPicS03 = json['thumbnail_pic_s03'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uniquekey'] = this.uniquekey;
    data['title'] = this.title;
    data['date'] = this.date;
    data['category'] = this.category;
    data['author_name'] = this.authorName;
    data['url'] = this.url;
    data['thumbnail_pic_s'] = this.thumbnailPicS;
    data['thumbnail_pic_s02'] = this.thumbnailPicS02;
    data['thumbnail_pic_s03'] = this.thumbnailPicS03;
    return data;
  }
}
