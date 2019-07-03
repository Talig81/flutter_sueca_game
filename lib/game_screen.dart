import 'dart:async';
import 'dart:math';
import 'dart:io';
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
  bool newAccepted = true;
  bool avail = false;
  List<PlayingCard> deck = [];
  int contador = -1;
  int acceptedCard;
  int cenas = 1;
  PlayingCard cardie;
  bool player1 = false;
  bool player2 = false;
  bool player3 = false;
  int p1, p2, p3;
  int jogada = 0;
  CardSuit naipe;
  int firstP = 1;
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
    this.modelo.initial();
    _gameStart();
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
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("images/table.jpg"),
                fit: BoxFit.cover,
              ),
            ),

            child: Container(
                child: Column(children: <Widget>[
                  Container(
                      child: player2
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                  createCard(this.modelo.p2.hand[p2], 1, false),
                                ])
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[buildFaceDown()],
                            ),
                      margin: new EdgeInsets.only(bottom: 20)),
                  Center(
                      child: Container(
                          child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  player1
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                              createCard(
                                                  this.modelo.p1.hand[p1],
                                                  1,
                                                  false),
                                            ])
                                      : Column(
                                          children: <Widget>[buildFaceDown()],
                                        ),
                                  Column(),
                                  player3
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                              createCard(
                                                  this.modelo.p3.hand[p3],
                                                  1,
                                                  false),
                                            ])
                                      : Column(
                                          children: <Widget>[
                                            buildFaceDown(),
                                          ],
                                        ),
                                ],
                              ),
                              constraints:
                                  BoxConstraints.expand(height: 75.0)))),
                  Expanded(
                      child: Container(
                          child: avail
                              ? Container(
                                  height: 35,
                                  width: 35,
                                  decoration: new BoxDecoration(
                                      border:
                                          new Border.all(color: Colors.green)),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        child: DragTarget(
                                      builder: (context,
                                          List<String> candidateData,
                                          rejectedData) {
                                        print("OnBuild" +
                                            candidateData.toString());

                                        return accepted
                                            ? Container(
                                                child: Row(
                                                children: <Widget>[
                                                  createCard(cardie, 1, false),
                                                ],
                                              ))
                                            : Container(
                                                height: 35,
                                                width: 35,
                                                decoration: new BoxDecoration(
                                                    border: new Border.all(
                                                        color: Colors.green)),
                                              );
                                      },
                                      onWillAccept: (data) {
                                        return true;
                                      },
                                      onAccept: (data) {
                                        print("OnAccept: " + data.toString());
                                        accepted = true;
                                        
                                        acceptedCard = parseToInt(data);
                                        print("data: "+acceptedCard.toString());
                                        if(isFirst){
                                          isFirst = false;
                                          this.naipe = this.modelo.p4.hand[acceptedCard].cardSuit;
                                        }
                                        cardie =
                                            this.modelo.p4.hand[acceptedCard];
                                            this.modelo.tableRound[4] = this.modelo.p4.hand[acceptedCard];
                                        
                                        this.modelo.p4.removeCard(acceptedCard);
                                        
                                        contador = -1;
                                        
                                        firstP = 1;
                                        _gameStart();
                                      },
                                    ))
                                  ],
                                ))),
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (PlayingCard c in this.modelo.p4.hand)
                            createCard(c, 1, true),
                        ]),
                  )
                ]))));
  }

  // Build the deck of cards left after building card columns

  Widget createCard(PlayingCard cont, int up, bool bo) {
    if (bo) contador++;
    return new Column(children: <Widget>[
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
      ]))
    ]);
  }

  Widget buildFaceDown() {
    return createCard(this.modelo.deck[0], 0, false);
  }
  void _showDialog(){
    showDialog(context: context,
    builder: (BuildContext context) {
      return AlertDialog(title: new Text("alertDialog"),
                        content: new Text(this.modelo.trunfo.toString()),
                        actions: <Widget>[ new FlatButton(
                          child: new Text("close"),
                          onPressed: () {Navigator.of(context).pop();},
                        )
                        ],
      );
                    
    },
    );
  }
  void _gameStart() {
    print("o trunfo é" + this.modelo.trunfo.toString());
    for(PlayingCard c in this.modelo.p3.hand){
      print("j3 card: " + c.cardSuit.toString()+ " - "+c.cardType.toString());
    }
    for(PlayingCard c in this.modelo.p1.hand){
      print("1J1J1J1 card: " + c.cardSuit.toString()+ " - "+c.cardType.toString());
    }
    for(PlayingCard c in this.modelo.p2.hand){
      print("j2 card: " + c.cardSuit.toString()+ " - "+c.cardType.toString());
    }
    for (; jogada < 10; jogada++) {
      
      while (this.modelo.tableRound.length != 4) {
        if (isFirst) {
          this.modelo.firstPP = firstP;
          switch (firstP) {
            case 1:
              p1 = this.modelo.p1.firstPlay();
              player1 = true;
              this.naipe = this.modelo.p1.hand[p1].cardSuit;
              this.modelo.tableRound[1] =(this.modelo.p1.hand[p1]);
              
              break;
            case 2:
              p2 = this.modelo.p2.firstPlay();
              player2 = true;
              this.naipe = this.modelo.p2.hand[p2].cardSuit;
              this.modelo.tableRound[2] = (this.modelo.p2.hand[p2]);
              break;
            case 3:
              p3 = this.modelo.p3.firstPlay();
              player3 = true;
              this.modelo.tableRound[3] = (this.modelo.p3.hand[p3]);
              this.naipe = this.modelo.p3.hand[p3].cardSuit;
              break;
            case 4:
              return;
          }
          isFirst = false;
        } else {
          switch (firstP) {
            case 1:
              p1 = this.modelo.p1.playCard(naipe);
              player1 = true;
              this.modelo.tableRound[1] = this.modelo.p1.hand[p1];
              break;
            case 2:
            print("estou no case 2-"+naipe.toString());
              p2 = this.modelo.p2.playCard(naipe);
              player2 = true;
              this.modelo.tableRound[2] =(this.modelo.p2.hand[p2]);
              break;
            case 3:
              print("estou no case 3-"+naipe.toString());
              p3 = this.modelo.p3.playCard(naipe);
              player3 = true;
              this.modelo.tableRound[3] = this.modelo.p3.hand[p3];
              break;
            case 4:
              return;
          }
        }
        
          firstP++;
        
      }
      print("comecei a dormir");
      sleep(const Duration(seconds:4));
      print("acabei");
      
      setState(() {
        
        this.modelo.p3.removeCard(p3);
        this.modelo.p2.removeCard(p2);
        this.modelo.p1.removeCard(p1);
        player1 = false;
        player2 = false;
        player3 = false;
        accepted = false;
        isFirst = true;
        
        firstP = this.modelo.gameScore();
        this.modelo.tableRound.clear();
      });
      print("fiz um cenas");

    }
    print("acabei um jogo");
  }

  int parseToInt(String cenas) {
    print(cenas + "olaa");
    var lista = cenas.split('|');

    return int.parse(lista[2]);
  }
}
