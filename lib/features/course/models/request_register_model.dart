class RequestRegisterModel {
  final String imageLink;
  final String registerId;

  RequestRegisterModel({
    required this.imageLink,
    required this.registerId,
  });

  factory RequestRegisterModel.fromJson(Map<String, dynamic> json) {
    return RequestRegisterModel(
      imageLink: json['ImageLink'] ?? '',
      registerId: json['RegisterId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ImageLink': imageLink,
      'RegisterId': registerId,
    };
  }
}
