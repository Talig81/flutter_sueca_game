import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter_counter/cards.dart';
import 'package:flutter_counter/suecamodel.dart';

import 'TransformedCard.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  
  SuecaModel modelo = new SuecaModel();
  
  bool accepted = false;
  List<PlayingCard> deck = [];
  int contador = -1;
  int acceptedCard;
  int cenas=1;
  PlayingCard cardie;

  @override
  void initState() {
    super.initState();
    this.modelo.initial();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green,
          actions: <Widget>[
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
              splashColor: Colors.white,
              onTap: () {
                super.initState();
                
              },
            )
          ],
        ),
        body: Container(
            color: Colors.blue,
            /*decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("images/table.jpg"),
                fit: BoxFit.cover,
              ),
            ),*/

            child: Container(
                color: Colors.yellow,
                child: Column(children: <Widget>[
                  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[buildFaceDown()],
                      ),
                      margin: new EdgeInsets.only(bottom: 20)),
                  Center(
                      child: Container(
                          color: Colors.white,
                          child: Container(
                              color: Colors.red,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[buildFaceDown()],
                                  ),
                                  Column(),
                                  Column(
                                    children: <Widget>[createCard(this.modelo.p1.hand[2], 1,false)],
                                  ),
                                ],
                              ),
                              constraints:
                                  BoxConstraints.expand(height: 75.0)))),
                  Expanded(
                      child: Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  child: DragTarget(
                                builder: (context, List<String> candidateData,
                                    rejectedData) {
                                  print("OnBuild" + candidateData.toString());
                                  
                                  return accepted
                                      ? Container(
                                        child: Row(children: <Widget>[
                                          createCard(cardie,1,false),
                                        
                                          
                                        ],)
                                      )
                                      : Container(
                                          height: 35,
                                          width: 35,
                                          color: Colors.red,
                                        );
                                },
                                onWillAccept: (data) {
                                  return true;
                                },
                                onAccept: (data) {
                                  print("OnAccept: " + data.toString());
                                  accepted = true;
                                  acceptedCard = parseToInt(data);
                                  print(acceptedCard);
                                  _warnMe();
                                },
                              ))
                            ],
                          ))),
                  Container(
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[ 
                        for(PlayingCard c in this.modelo.p4.hand)     
                              createCard(c,1, true),
                        ]
                    ),
                  )
                ]))));
  }

  // Build the deck of cards left after building card columns
 

  Widget createCard(PlayingCard cont, int up, bool bo) {
    if(bo) contador++;
    return new Column(
                          children: <Widget>[                
      Container(
        child: Row(children: <Widget>[
      InkWell(
          child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TransformedCard(
          playingCard: cont,
          contador: contador,
          upwards: up,
        ),
      ))
    ]))]);
  }

  Widget buildFaceDown(){
      return createCard(this.modelo.deck[0],0,false);
  }

  void _warnMe(){
    print("corri");
    cardie = this.modelo.p4.hand[acceptedCard];
    setState((){this.modelo.p4.removeCard(acceptedCard);print("im in");cenas=2;contador=0;});
    print(this.modelo.p4.hand.length);
    print("nao da");
  }

  int parseToInt (String cenas){
    print(cenas + "olaa");
    var lista = cenas.split('|');
    
    return int.parse(lista[2]);
  }

  
  

}
