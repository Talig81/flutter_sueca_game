import 'package:flutter_counter/cards.dart';
import 'package:flutter_counter/player.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'dart:math';

class SuecaModel {
  List<PlayingCard> deck = [];
  Player p1 = new Player();
  Player p2 = new Player();
  Player p3 = new Player();
  Player p4 = new Player();
  int firstStarted;
  Map<int, PlayingCard> tableRound = new Map();
  Map<CardType, int> cardValue = new Map();
  CardSuit trunfo = randomChoice(CardSuit.values);
  int firstPP = -1;
  Map<CardType, int> points = new Map();
  int totalTeu = 0;
  CardSuit naipeJ;

  SuecaModel(
      {this.deck, this.p1, this.p2, this.p3, this.p4, this.firstStarted});

  void initial() {
    _auxP();
    this.firstStarted = 2;
    this.deck = [];
    p1 = new Player();
    p2 = new Player();
    p3 = new Player();
    p4 = new Player();
    CardSuit.values.forEach((suit) {
      CardType.values.forEach((type) {
        this.deck.add(PlayingCard(
              cardType: type,
              cardSuit: suit,
            ));
      });
    });
    shuffleDeck(deck);
    for (int i = 0; i < 40; i++) {
      print(deck[i]);
      if (i < 10) p1.addCards(deck[i]);
      if (i < 20 && i > 9) p2.addCards(deck[i]);
      if (i < 30 && i > 19) p3.addCards(deck[i]);
      if (i < 40 && i > 29) p4.addCards(deck[i]);
    }
    p1.addPosition(1);
    p2.addPosition(2);
    p3.addPosition(3);
    p4.addPosition(4);
  }

  PlayingCard compCard(PlayingCard a, PlayingCard b) {
    if (this.cardValue[a.cardType] > this.cardValue[b.cardType])
      return a;
    else
      return b;
  }

  int gameScore() {
    PlayingCard cartaMaior;
    cartaMaior = this.tableRound[this.firstPP];
    print("my numbeer");
    print(this.tableRound);
    this.naipeJ = this.tableRound[this.firstPP].cardSuit;
    for (PlayingCard cd in this.tableRound.values) {
      if (cartaMaior != cd) {
        if (cd.cardSuit == this.trunfo && cartaMaior.cardSuit == this.trunfo) {
          cartaMaior = compCard(cartaMaior, cd);
        } else if (cd.cardSuit == this.trunfo) {
          cartaMaior = cd;
        } else if (cartaMaior.cardSuit != this.trunfo &&
            cd.cardSuit == cartaMaior.cardSuit) {
          cartaMaior = compCard(cartaMaior, cd);
        }
      }
    }

    int auxScore = this
        .tableRound
        .keys
        .firstWhere((x) => this.tableRound[x] == cartaMaior, orElse: () => 1);

    if ((auxScore == 2)) {
      this.totalTeu += this.points[this.tableRound[auxScore].cardType] +
          this.points[this.tableRound[4].cardType];
    } else if (auxScore == 4) {
      this.totalTeu += this.points[this.tableRound[auxScore].cardType] +
          this.points[this.tableRound[2].cardType];
    }

    print("Ola malta, o score é: " + this.totalTeu.toString());
    return auxScore;
  }

  void _auxP() {
    for (CardType tt in CardType.values) {
      switch (tt) {
        case CardType.ace:
          this.points[tt] = 11;
          this.cardValue[tt] = 10;
          break;
        case CardType.seven:
          this.points[tt] = 10;
          this.cardValue[tt] = 9;
          break;
        case CardType.king:
          this.points[tt] = 4;
          this.cardValue[tt] = 8;
          break;
        case CardType.queen:
          this.points[tt] = 2;
          this.cardValue[tt] = 6;
          break;
        case CardType.jack:
          this.points[tt] = 3;
          this.cardValue[tt] = 7;
          break;
        case CardType.six:
          this.points[tt] = 0;
          this.cardValue[tt] = 5;
          break;
        case CardType.five:
          this.points[tt] = 0;
          this.cardValue[tt] = 4;
          break;
        case CardType.four:
          this.points[tt] = 0;
          this.cardValue[tt] = 3;
          break;
        case CardType.three:
          this.points[tt] = 0;
          this.cardValue[tt] = 2;
          break;
        case CardType.two:
          this.points[tt] = 0;
          this.cardValue[tt] = 1;
          break;
        default:
          this.points[tt] = 0;
          break;
      }
    }
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
