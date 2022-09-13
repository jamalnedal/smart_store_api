class Images {
  int? id;
  int? objectId;
  String? url;
  String? imageUrl;

  Images({this.id, this.objectId, this.url, this.imageUrl});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    objectId = json['object_id'];
    url = json['url'];
    imageUrl = json['image_url'];
  }

}