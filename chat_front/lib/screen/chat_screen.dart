import 'dart:convert';
import 'dart:io';

import 'package:chat_front/componentes/caixa_mensagem.dart';
import 'package:chat_front/models/mensagem.dart';
import 'package:flutter/material.dart';

var socketAux;
List<Mensagem> mensagens = [];

class ChatConversa extends StatefulWidget {
  const ChatConversa({Key? key}) : super(key: key);

  @override
  _ChatConversaState createState() {
    return _ChatConversaState();
  }
}

class _ChatConversaState extends State<ChatConversa> {
  TextEditingController controller = TextEditingController();
  Mensagem mensagem = Mensagem();

  void enviarMensagem(Socket socket, String mensagemEnviada) {
    setState(() {
      socket.write(mensagemEnviada);
    });
  }

  Future<void> chamarSocket() async {
    final socket = await Socket.connect('10.0.2.2', 3000);
    socketAux = socket;

    socket.listen(
      (dados) async {
        final serverResponse = String.fromCharCodes(dados);

        print(serverResponse);

        if (mensagens.isEmpty) {
          for (String item in serverResponse.split('%%')) {
            print(item);
            mensagens.add(Mensagem.fromMap(jsonDecode(item)));
          }
        } else {
          mensagens.add(Mensagem.fromMap(jsonDecode(serverResponse)));
        }

        // mensagens.add(novaMensagem);
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
  }

  void _reset() {
    controller.clear();
  }

  @override
  void initState() {
    super.initState();
    chamarSocket();
  }

  @override
  Widget build(BuildContext context) {
    mensagem.nome = 'Rafael';

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
                    return CaixaMensagem(
                      texto: mensagens[index].mensagem,
                      nome: mensagens[index].nome,
                      data: mensagens[index].data,
                      mine: true,
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
                    mensagem.mensagem = controller.text;
                    mensagem.data = DateTime.now().toString();
                    String jsonMensagem = jsonEncode(mensagem.toMap());

                    enviarMensagem(socketAux, jsonMensagem);
                    _reset();
                  },
                  icon: Icon(Icons.send))
            ],
          )
        ],
      ),
    );
  }
}
