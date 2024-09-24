class GalleryItem {
  final String id;
  final String name;
  final int uid;
  final int docType;
  final String url;

  GalleryItem({
    required this.id,
    required this.name,
    required this.uid,
    required this.docType,
    required this.url,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      id: json['_id'],
      name: json['_name'],
      uid: json['_uid'],
      docType: json['_docType'],
      url: json['_url'],
    );
  }
}