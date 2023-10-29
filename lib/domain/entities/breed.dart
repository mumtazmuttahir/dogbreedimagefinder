class RandomBreed {
  String? _message;
  String? _status;

  RandomBreed({String? message, String? status}) {
    if (message != null) {
      message = message;
    }
    if (status != null) {
      _status = status;
    }
  }

  //From Json
  RandomBreed.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    _status = json['status'];
  }

  //To Json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = _message;
    data['status'] = _status;
    return data;
  }

  //Getters and Setters
  String? get message => _message;
  set message(String? message) => _message = message;
  String? get status => _status;
  set status(String? status) => _status = status;
}
