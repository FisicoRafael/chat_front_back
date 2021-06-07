import 'dart:io';

import 'package:flutter/material.dart';

var socket_aux;
List mensagens = [];

Future<void> main() async {
  final socket = await Socket.connect('10.0.2.2', 3000);
  socket_aux = socket;

  socket.listen(
    (dados) async {
      final serverResponse = String.fromCharCodes(dados);

      if (mensagens.isEmpty) {
        for (String item in serverResponse.split(',')) {
          mensagens.add(item);
        }
      } else {
        mensagens.add(serverResponse);
      }
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

void enviarMensagem(Socket socket, String mensagem) {
  socket.write(mensagem);
}

class MeuChat extends StatelessWidget {
  const MeuChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatConversa(),
    );
  }
}

class ChatConversa extends StatefulWidget {
  const ChatConversa({Key? key}) : super(key: key);

  @override
  _ChatConversaState createState() {
    return _ChatConversaState();
  }
}

class _ChatConversaState extends State<ChatConversa> {
  TextEditingController controller = TextEditingController();

  void _reset() {
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    print(mensagens);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat com Back'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: mensagens.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(mensagens[index]),
                    );
                  })),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: TextField(
                controller: controller,
              )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      enviarMensagem(socket_aux, controller.text);
                      _reset();
                    });
                  },
                  icon: Icon(Icons.send))
            ],
          )
        ],
      ),
    );
  }
}
