class RandomImageByBreed {
  List<String>? _message;
  String? _status;

  RandomImageByBreed({List<String>? message, String? status}) {
    if (message != null) {
      _message = message;
    }
    if (status != null) {
      _status = status;
    }
  }

  List<String>? get message => _message;
  set message(List<String>? message) => _message = message;
  String? get status => _status;
  set status(String? status) => _status = status;

  RandomImageByBreed.fromJson(Map<String, dynamic> json) {
    _message = json['message'].cast<String>();
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = _message;
    data['status'] = _status;
    return data;
  }
}
