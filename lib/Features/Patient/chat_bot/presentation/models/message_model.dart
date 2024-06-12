
class MessageModel {
  String? message;
  bool? isUserMessage;
  MessageModel({this.message, this.isUserMessage});
  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isUserMessage = json['isUserMessage'];
  }
  Map<String, dynamic> toJson() =>{
    'message': message,
    'isUserMessage': isUserMessage
  };
}