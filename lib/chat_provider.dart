import 'package:flutter/material.dart';
import 'package:flutter_chatbot/chat_model.dart';
import 'package:flutter_chatbot/chatbot.dart';

class ChatProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  final ChatBot _chatService = ChatBot();

  void addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }

  Future<void> sendMessage(String message) async {
    addMessage(ChatMessage(message: message, isUser: true));
    final response = await _chatService.getChatResponse(message);
    addMessage(ChatMessage(message: response, isUser: false));
  }
}
