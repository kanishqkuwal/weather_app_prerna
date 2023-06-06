import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  final String id;

  const MessageScreen({Key? key,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message Screen'+id)
        ,),
    );
  }
}
