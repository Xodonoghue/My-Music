import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  final String message;
  const MessageView({required this.message,super.key});

  @override
  Widget build(BuildContext context) {
    
    return Container(child: Text(message),);
  }
}