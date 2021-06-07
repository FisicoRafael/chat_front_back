
import 'dart:io';

void main() async {
  // bind the socket server to an address and port
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, 65425);

  
   server.listen((client) {
     escutarCliente(client);
   });
}

void escutarCliente(Socket client) {
  print('Conexição de ${client.remoteAddress.address}:${client.remotePort}');
  client.listen((dados) async {     
    final mensagem = String.fromCharCodes(dados);
    client.write(mensagem);
    
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


