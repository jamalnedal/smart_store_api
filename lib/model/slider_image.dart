class SliderHome{
  late int id;
  late String objectId;
 late String url;
  late String imageUrl;

  SliderHome({required this.id, required this.objectId, required this.url, required this.imageUrl});

  SliderHome.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  objectId = json['object_id'];
  url = json['url'];
  imageUrl = json['image_url'];
  }}