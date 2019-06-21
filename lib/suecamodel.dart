import 'package:flutter_counter/cards.dart';
import 'package:flutter_counter/player.dart';
import 'dart:math';

class SuecaModel {
  List<PlayingCard> deck = [];
  Player p1 = new Player();
  Player p2= new Player(); 
  Player p3= new Player();
  Player p4= new Player();
  int firstStarted;

  SuecaModel({this.deck, this.p1, this.p2, this.p3, this.p4, this.firstStarted});

  void initial() {
    this.firstStarted = 2;
    this.deck = [];
   p1 = new Player();
   p2= new Player(); 
   p3= new Player();
   p4= new Player();
    CardSuit.values.forEach((suit) {
      CardType.values.forEach((type) {
        this.deck.add(PlayingCard(
          cardType: type,
          cardSuit: suit,
        ));
      });
    });
    shuffleDeck(deck);
    for(int i = 0; i<40; i++){
      print(deck[i]);
      if(i<10) p1.addCards(deck[i]);
      if(i<20&&i>9) p2.addCards(deck[i]);
      if(i<30 && i>19) p3.addCards(deck[i]);
      if(i<40 && i>29) p4.addCards(deck[i]);
    }
    p1.addPosition(1);
    p2.addPosition(2);
    p3.addPosition(3);
    p4.addPosition(4);



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
