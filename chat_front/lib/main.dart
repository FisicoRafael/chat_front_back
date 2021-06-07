
import 'dart:io';

import 'package:flutter/material.dart';


var socket_aux;

Future<void> main() async {

  final socket = await  Socket.connect('10.0.2.2', 65425);
  socket_aux=socket;

  socket.listen((dados) {
    final serverResponse = String.fromCharCodes(dados); 
    print('Servidor: $serverResponse');
  },
    onError: (error) {
      print(error);
      socket.destroy();
    },

    onDone: () {
      print('Server left.');
      socket.destroy();
    },
  
   );
  

  runApp(MeuChat());
}


void enviarMensagem(Socket socket, String mensagem){
  socket.write(mensagem);
}

class MeuChat extends StatelessWidget {
  const MeuChat({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatConversa(),
    );
  }
}

class ChatConversa extends StatefulWidget {
  const ChatConversa({ Key? key }) : super(key: key);

  @override
  _ChatConversaState createState() => _ChatConversaState();
}

class _ChatConversaState extends State<ChatConversa> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat com Back'), centerTitle: true,),
      body: Column(children: [
        Expanded(
          child: ListView.builder(itemCount: 1,
          itemBuilder: (context, index){
            return ListTile(
              title: Text('teste'),
            );
          }),
        ),
        Row(mainAxisSize: MainAxisSize.min,
        children: [          
          Expanded(child: TextField(
            controller: controller,
          )), 
           IconButton(onPressed: (){
              enviarMensagem(socket_aux, controller.text);
           }, icon: Icon(Icons.send))
        ],)
      ],),
    );
  }
}


