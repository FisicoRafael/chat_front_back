
import 'dart:io';

void main() async {
  // bind the socket server to an address and port
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, 3000);

  
   server.listen((client) {
     escutarCliente(client);
   });
}

List<String> mensagens = [];

Future<void> escutarCliente(Socket client)  async {
  print('Conexição de ${client.remoteAddress.address}:${client.remotePort}');
 

  if (mensagens.isNotEmpty ) {            
      client.writeAll(mensagens, ',');
      
    }  

    

  client.listen((dados) async { 

          
    final mensagem = String.fromCharCodes(dados);    
    mensagens.add(mensagem);     
    client.write(mensagem); 
    
    print(mensagens[mensagens.length-1]);
    print(mensagens);
    
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


