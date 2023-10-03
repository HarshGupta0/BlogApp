class NewsQueryModel {
  final String newsImg;
  final String newsHead;
  // late String newsDes;
  // late String newsUrl;
  NewsQueryModel({
    this.newsImg = "SOME URL",
    this.newsHead = "NEWS HEADLINE",
    // this.newsDes = "SOME NEWS",
    // this.newsUrl = "SOME URL"
  });
  factory NewsQueryModel.fromMap(Map news) {
    return NewsQueryModel(
        newsHead: news["title"],
        newsImg: news["image_url"] ?? "https://tse4.mm.bing.net/th?id=OIP.O21Q6ByDjlqd7OoD0LWpCwHaE8&pid=Api&P=0&h=180",
        // newsDes: news["description"],
        // newsUrl: news["url"]
    );
  }
}
