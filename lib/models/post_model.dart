class PostModel {

  final String id;
  final String type;
  final String itemName;
  final String description;
  final String location;
  final String category;
  final String userId;
  final String userName;
  final String userAvatar;
  final String status;
  final String contactInfo;

  PostModel({
    required this.id,
    required this.type,
    required this.itemName,
    required this.description,
    required this.location,
    required this.category,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.status,
    required this.contactInfo,
  });

  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'type': type,
      'itemName': itemName,
      'description': description,
      'location': location,
      'category': category,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'status': status,
      'contactInfo': contactInfo,
    };
  }

  factory PostModel.fromMap(
      Map<String, dynamic> map,
      ) {

    return PostModel(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      itemName: map['itemName'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      category: map['category'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      userAvatar: map['userAvatar'] ?? '',
      status: map['status'] ?? '',
      contactInfo: map['contactInfo'] ?? '',
    );
  }
}