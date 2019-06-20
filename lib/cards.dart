import 'package:flutter/material.dart';

enum CardSuit {
  spades,
  hearts,
  diamonds,
  clubs,
}

enum CardType {
  two,
  three,
  four,
  five,
  six,
  seven,
  jack,
  queen,
  king,
  ace,
}

enum CardColor {
  red,
  black,
}

// Simple playing card model
class PlayingCard {
  CardSuit cardSuit;
  CardType cardType;

  PlayingCard({
    @required this.cardSuit,
    @required this.cardType,
  });
}