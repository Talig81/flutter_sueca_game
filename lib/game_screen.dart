import 'dart:math';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_counter/cards.dart';

import 'TransformedCard.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<PlayingCard> handCards = [];
  List<PlayingCard> playCards = [];
  List<PlayingCard> finalPlayCards = [];
  int tempor = 0;
  int nCardsPlayer=10;
  int aux = 10;
  int aux2 = 20;
  int aux3 = 30;
  bool accepted = false;
  int acceptedCard;
  String playSuit = 'spades';

  List<PlayingCard> deck = [];
  int contador = 0;

  @override
  void initState() {
    super.initState();
    _initialiseGame();
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
                Navigator.pop(context);
                _initialiseGame();
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
                        children: <Widget>[_buildCardDeck(1)],
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
                                    children: <Widget>[_buildCardDeck(3)],
                                  ),
                                  Column(),
                                  Column(
                                    children: <Widget>[_buildCardDeck(2)],
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
                                          createCard(acceptedCard),
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
                                },
                              ))
                            ],
                          ))),
                  Container(
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for(int i = 0; i<nCardsPlayer;i++ )
                          _buildColumn(1)
                      ],
                    ),
                  )
                ]))));
  }

  // Build the deck of cards left after building card columns
  Widget _buildCardDeck(int i) {
    switch (i) {
      case 4:
        contador++;
        return createCard(contador - 1);
        break;
      case 1:
        aux++;
        return createCard(aux - 1);
        break;
      case 2:
        aux2++;
        return createCard(aux2 - 1);
        break;
      case 3:
        aux3++;
        return createCard(aux3 - 1);
        break;
    }
  }

  Widget createCard(int cont) {
    return Container(
        child: Row(children: <Widget>[
      InkWell(
          child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TransformedCard(
          playingCard: deck[cont],
          contador: cont,
        ),
      ))
    ]));
  }

  int parseToInt (String cenas){
    print(cenas + "olaa");
    var lista = cenas.split('|');
    
    return int.parse(lista[2]);
  }

  void _initialiseGame() {
    handCards = [];
    playCards = [];
    finalPlayCards = [];

    deck = [];

    CardSuit.values.forEach((suit) {
      CardType.values.forEach((type) {
        deck.add(PlayingCard(
          cardType: type,
          cardSuit: suit,
        ));
      });
    });

    shuffleDeck(deck);

    for (int i = 0; i < 10; i++) {
      playCards.add(deck[i]);
    }
  }

  Widget _buildColumn(int cont){
    return new Column(
                          children: <Widget>[
                            _buildCardDeck(cont),
                          ],);
  }

  List shuffleDeck(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }
}
