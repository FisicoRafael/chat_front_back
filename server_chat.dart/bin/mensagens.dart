
final String nomeColuna = "nomeColuna";
final String mensagemColuna = "mensagemColuna";
final String dataColuna = "dataColuna";

class Mensagem{

  String? nome = 'Rafael';
  String? mensagem;
  String? data;

  Mensagem();

  Mensagem.fromMap(Map map){
    nome = map[nomeColuna];
    mensagem = map[mensagemColuna];
    data = map[dataColuna];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      nomeColuna: nome,
      mensagemColuna: mensagem,
      dataColuna: data,
    };
    return map;
  }



}