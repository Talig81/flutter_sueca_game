import 'package:flutter_counter/cards.dart';
import 'dart:math';

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

int firstPlay(){
  var newR = new Random();
  return newR.nextInt(this.hand.length);
}

int playCard(CardSuit naipe){
print("naipe :" + naipe.toString());
  for(int i = 0; i<this.hand.length;i++){
    if(this.hand[i].cardSuit == naipe) return i;
  }
  return 0;
}


}