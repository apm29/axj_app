class ImageDetail {
  String orginPicPath;
  String thumbnailPath;

  ImageDetail({this.orginPicPath, this.thumbnailPath});

  ImageDetail.fromJson(Map<String, dynamic> json) {
    orginPicPath = json['orginPicPath'];
    thumbnailPath = json['thumbnailPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orginPicPath'] = this.orginPicPath;
    data['thumbnailPath'] = this.thumbnailPath;
    return data;
  }
}