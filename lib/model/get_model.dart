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
  // static NewsQueryModel fromAPItoApp(Map <String,dynamic> blog) {
  //   return NewsQueryModel(
  //       newsImg: blog['image_url'] ?? "https://in.images.search.yahoo.com/images/view;_ylt=AwrPrUuBghpluEENTjS9HAx.;_ylu=c2VjA3NyBHNsawNpbWcEb2lkAzFmMDhkYjYyODI5NjNiNDBkN2I0ZDRjZGMxZDQxZDAzBGdwb3MDMgRpdANiaW5n?back=https%3A%2F%2Fin.images.search.yahoo.com%2Fsearch%2Fimages%3Fp%3Dnews%2Bimage%26fr%3Dmcafee%26tab%3Dorganic%26ri%3D2&w=2800&h=1867&imgurl=kchanews.com%2Fwp-content%2Fuploads%2F2014%2F09%2Fbigstock-Breaking-News-Screen-36237841.jpg&rurl=https%3A%2F%2Fkchanews.com%2Fbreaking-news-screen%2F&size=93.3KB&p=news+image&oid=1f08db6282963b40d7b4d4cdc1d41d03&fr2=&fr=mcafee&tt=Breaking+News+Screen+%E2%80%93+KCHA+News&b=0&ni=180&no=2&ts=&tab=organic&sigr=5HeDkSKDGEwU&sigb=n_IvNfOo1otz&sigi=iv_kSjO7LJr.&sigt=yKKIoW9DFD_J&.crumb=phAMTTSlv9E&fr=mcafee",
  //       newsHead: blog['title'] ?? "---",
  //   );

  factory NewsQueryModel.fromMap(Map news) {
    return NewsQueryModel(
        newsHead: news["title"],
        newsImg: news["image_url"],
        // newsDes: news["description"],
        // newsUrl: news["url"]
    );
  }
}
