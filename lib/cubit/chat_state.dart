class ChatState {}

class loading extends ChatState {}

class succes extends ChatState {}

class exception extends ChatState {
  String error;
  exception({required this.error});
}
