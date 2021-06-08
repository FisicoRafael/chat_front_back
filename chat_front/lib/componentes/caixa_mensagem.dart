import 'package:flutter/material.dart';

class CaixaMensagem extends StatelessWidget {
  const CaixaMensagem(
      {Key? key,
      required this.mine,
      required this.nome,
      required this.texto,
      required this.data})
      : super(key: key);

  final bool mine;
  final String nome;
  final String texto;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          !mine
              ? Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/padrao.jpg'),
                  ),
                )
              : Container(),
          Expanded(
              child: Column(
            crossAxisAlignment:
                mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                texto,
                textAlign: mine ? TextAlign.end : TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                nome+'---'+data,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              )
            ],
          )),
          mine
              ? Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/padrao.jpg'),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
