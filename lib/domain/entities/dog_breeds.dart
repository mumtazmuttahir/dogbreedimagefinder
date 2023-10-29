class DogBreeds {
  Map<String, List<String>> message;
  String status;

  DogBreeds({required this.message, required this.status});

  factory DogBreeds.fromJson(Map<String, dynamic> json) {
    return DogBreeds(
      message: (json['message'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, (value as List<dynamic>).cast<String>()),
      ),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
    };
  }
}
