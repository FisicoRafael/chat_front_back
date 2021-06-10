
import 'dart:convert';
import 'dart:io';

import 'mensagens.dart';

void main() async {
  // bind the socket server to an address and port
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, 3000);

  
   server.listen((client) {
     escutarCliente(client);
   });
}

List<Mensagem> mensagens = [];


Future<void> escutarCliente(Socket client)  async {
  print('Conexição de ${client.remoteAddress.address}:${client.remotePort}');
 

  if (mensagens.isNotEmpty ) {  
    List<String> novoItem = [];
    for (var item in mensagens) {
      novoItem.add(jsonEncode(item.toMap()));          
          }   
      client.writeAll(novoItem,'%%');         
    }      

  client.listen((dados) async { 

          
    final mensagem = String.fromCharCodes(dados);  
    
    var novaMensagem = Mensagem.fromMap(jsonDecode(mensagem));
    print(mensagem);  
    mensagens.add(novaMensagem);     
    client.write(mensagem); 
    
    // print(mensagens[mensagens.length-1]);
    
    
  },

      onError: (error) {
      print(error);
      client.close();
},

     onDone: () {
      print('Client left');
      client.close();
      
    },

  );
}


