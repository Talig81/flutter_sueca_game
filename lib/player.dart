import 'package:flutter_counter/cards.dart';

class Player{
    List<PlayingCard> hand = [];
    int position;

Player(){
    this.hand = [];
    this.position=0;
}

void addCards(PlayingCard card){
  this.hand.add(card);
}

void addPosition(int i){
  this.position = i;
}

void removeCard(int i){
  print(i);
  this.hand.remove(this.hand[i]);
  
  print(this.hand.length);
}


}