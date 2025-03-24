import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yesnoapp/domain/entities/message.dart';
import 'package:yesnoapp/presentation/providers/chat_provider.dart';
import 'package:yesnoapp/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yesnoapp/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yesnoapp/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget
{
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding
        (
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://d1rig8ldkblbsy.cloudfront.net/app/uploads/2021/06/24115325/jennifer-aniston-crop-1624532037-1172x1172.jpg'),
          ),
        ),
        title: Text('Mi amor'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder
              (
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.messageList.length,
                itemBuilder: (context, index) 
                {
                  final message = chatProvider.messageList[index];
                  
                  return (message.fromWho == FromWho.hers) ? 
                    HerMessageBubble(message: message) : MyMessageBubble(message: message);
                },
              )
            ),
            //Caja de Texto
            MessageFieldBox
            (
              //onValue: (value) => chatProvider.sendMessage(value),
              onValue: chatProvider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}