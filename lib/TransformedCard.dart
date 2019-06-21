
import 'package:flutter/material.dart';
import 'package:flutter_counter/cards.dart';


class TransformedCard extends StatefulWidget {
  final PlayingCard playingCard;
  final int contador;
  final double transformDistance;
  int upwards =0;

  TransformedCard({
    @required this.playingCard,
    this.contador,
    @required this.upwards,
    this.transformDistance = 15.0,

  });

  

  @override
  _TransformedCardState createState() => _TransformedCardState();
}

class _TransformedCardState extends State<TransformedCard> {
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          0.0,
          1 * widget.transformDistance,
          0.0,
        ),
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    if(this.widget.upwards == 1){
        var draggable = Draggable(
          child: _buildFaceUpCard(),
          feedback: _buildFaceUpCard(),
          childWhenDragging: Container(),
          data: widget.playingCard.cardSuit.toString()+ '|'+ widget.playingCard.cardType.toString() + '|'+widget.contador.toString()  ,
          onDragCompleted: () {Container();},
            
        );
        return draggable;
    }
    else return Container(
    height: 60.0,
    width: 40.0,
    decoration: BoxDecoration(
      color: Colors.blue,
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
  }


String _cardTypeToString() {
    switch (widget.playingCard.cardType) {
      case CardType.ace:
        return "A";
      case CardType.two:
        return "2";
      case CardType.three:
        return "3";
      case CardType.four:
        return "4";
      case CardType.five:
        return "5";
      case CardType.six:
        return "6";
      case CardType.seven:
        return "7";
      case CardType.jack:
        return "J";
      case CardType.queen:
        return "Q";
      case CardType.king:
        return "K";
      default:
        return "";
    }
}
Widget _buildFaceUpCard() {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        height: 50,
        width: 35,
        child: Stack(
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: Text(
                      _cardTypeToString(),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    height: 20.0,
                    child: _suitToImage(),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _cardTypeToString(),
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                    Container(
                      height: 7.5,
                      child: _suitToImage(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Image _suitToImage() {
    switch (widget.playingCard.cardSuit) {
      case CardSuit.hearts:
        return Image.asset('images/hearts.png');
      case CardSuit.diamonds:
        return Image.asset('images/diamonds.png');
      case CardSuit.clubs:
        return Image.asset('images/clubs.png');
      case CardSuit.spades:
        return Image.asset('images/spades.png');
      default:
        return null;
    }
  }

}