import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import 'package:flutter/services.dart';
import 'constants.dart';

void main() => runApp(SnakeGameMain());

class SnakeGameMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SnakeGame(),
    );
  }
}

class SnakeGame extends StatefulWidget {
  @override
  _SnakeGameState createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  static const int INITIAL_TIME_REFRESH_PAGE = 200;

  final randomGen = Random();

//  var food = [(SQUARES_PER_ROW / 2).floor(), (SQUARES_PER_COL / 2).floor()-2];
//
//  var snake = [ // Snake head
//    [(SQUARES_PER_ROW / 2).floor(), (SQUARES_PER_COL / 2).floor()],
//    [(SQUARES_PER_ROW / 2).floor(), (SQUARES_PER_COL / 2).floor()+1],
//    [(SQUARES_PER_ROW / 2).floor(), (SQUARES_PER_COL / 2).floor()+2],
//    [(SQUARES_PER_ROW / 2).floor(), (SQUARES_PER_COL / 2).floor()+3],
//    [(SQUARES_PER_ROW / 2).floor(), (SQUARES_PER_COL / 2).floor()+4],
//  ];

  //SHOWCASE:

  var food = [15, 2];

  var snake = [
    [13, 2], // Snake head
    [12, 2],
    [11, 2],
    [10, 2],
    [10, 3],
    [10, 4],
    [9, 4],
    [8, 4],
    [7, 4],
    [7, 5],
    [7, 6],
    [8, 6],

    //S
    [2, 9],
    [1, 9],
    [0, 9],
    [0, 10],
    [0, 11],
    [1, 11],
    [2, 11],
    [2, 12],
    [2, 13],
    [1, 13],
    [0, 13],

    //N
    [4, 9],
    [4, 10],
    [4, 11],
    [4, 12],
    [4, 13],
    [5, 10],
    [6, 11],
    [7, 13],
    [7, 12],
    [7, 11],
    [7, 10],
    [7, 9],

    //A
    [9, 13],
    [9, 12],
    [9, 11],
    [9, 10],
    [10, 9],
    [10, 11],
    [11, 13],
    [11, 12],
    [11, 11],
    [11, 10],

    //K
    [13, 13],
    [13, 12],
    [13, 11],
    [13, 10],
    [13, 9],
    [15, 9],
    [15, 10],
    [14, 11],
    [15, 12],
    [15, 13],

    //E
    [17, 13],
    [17, 12],
    [17, 11],
    [17, 10],
    [17, 9],
    [18, 9],
    [19, 9],
    [18, 11],
    [18, 13],
    [19, 13],
  ];

  String direction = UP;
  var isPlaying = false;
  Color colorPlayingButton = COLOR_THEME;
  bool lightTheme = false;
  int speed = 200;
  int timeRefreshPage = INITIAL_TIME_REFRESH_PAGE;
  TextStyle fontStyle = new TextStyle();

  Widget build(BuildContext context) {
    final fontStyle = TextStyle(
        color: lightTheme ? Colors.black : Colors.white, fontSize: 20);
    colorPlayingButton = isPlaying ? Colors.red : COLOR_THEME;
    Color backgroundColor = lightTheme ? Colors.grey[200] : Colors.black;
    SystemChrome.setSystemUIOverlayStyle(
        lightTheme ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: _buildBody(fontStyle),
    );
  }

  Column _buildBody(TextStyle fontStyle) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              if (direction != UP && details.delta.dy > 0) {
                direction = DOWN;
              } else if (direction != DOWN && details.delta.dy < 0) {
                direction = UP;
              }
            },
            onHorizontalDragUpdate: (details) {
              if (direction != LEFT && details.delta.dx > 0) {
                direction = RIGHT;
              } else if (direction != RIGHT && details.delta.dx < 0) {
                direction = LEFT;
              }
            },
            child: _buildPixelsGrid(),
          ),
        ),
        _buildBottomRow(fontStyle),
      ],
    );
  }

  Padding _buildBottomRow(TextStyle fontStyle) {
    return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: lightTheme ? COLOR_THEME : Colors.grey,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(50)),
                color: lightTheme ? COLOR_THEME : Colors.grey,
                child: Icon(
                  Icons.wb_sunny,
                  color: lightTheme ? Colors.black : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    lightTheme = !lightTheme;
                  });
                }),
            Column(
              children: [
                Text(
                  'Speed: ${speed}',
                  style: fontStyle,
                ),
                Text(
                  'Score: ${snake.length - 5}',
                  style: fontStyle,
                ),
              ],
            ),
            FlatButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: colorPlayingButton,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(50)),
                color: colorPlayingButton,
                child: Text(
                  isPlaying ? 'End' : 'Start',
                  style: fontStyle,
                ),
                onPressed: () {
                  if (isPlaying) {
                    isPlaying = false;
                  } else {
                    startGame();
                  }
                }),
          ],
        ));
  }

  Padding _buildPixelsGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: SQUARES_PER_ROW / (SQUARES_PER_COL + 5),
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: SQUARES_PER_ROW,
            ),
            itemCount: SQUARES_PER_ROW * SQUARES_PER_COL,
            itemBuilder: (BuildContext context, int index) {
              var color;
              var x = index % SQUARES_PER_ROW;
              var y = (index / SQUARES_PER_ROW).floor();

              bool isSnakeBody = false;
              for (var pos in snake) {
                if (pos[0] == x && pos[1] == y) {
                  isSnakeBody = true;
                  break;
                }
              }

              if (snake.first[0] == x && snake.first[1] == y) {
                color = lightTheme ? Colors.green[700] : Colors.green[500];
              } else if (isSnakeBody) {
                color = lightTheme ? Colors.green[500] : Colors.green[700];
              } else if (food[0] == x && food[1] == y) {
                color = Colors.red;
              } else {
                color = lightTheme ? COLOR_PIXEL_OFF : Colors.grey[900];
              }

              //final width = PixelSize.of(context).size.width;
              return SizedBox.fromSize(
                //size: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.all(0.05 * 18),
                  padding: EdgeInsets.all(0.1 * 18),
                  decoration: BoxDecoration(
                      //external section of the Pixel
                      shape: BoxShape.circle,
                      border: Border.all(width: 0.10 * 18, color: color)),
                  child: Container(
                    //color: color,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  void startGame() {
    Duration duration = Duration(milliseconds: INITIAL_TIME_REFRESH_PAGE);
    timeRefreshPage = INITIAL_TIME_REFRESH_PAGE;
    direction = UP;
    Timer gameTimer = createPeriodicTimer(duration);
    speed = 200;

    snake = [
      // Snake head
      [(SQUARES_PER_ROW / 2).floor(), (SQUARES_PER_COL / 2).floor()]
    ];

    snake.add([snake.first[0], snake.first[1] + 1]); // Snake body
    snake.add([snake.first[0], snake.first[1] + 2]); // Snake body
    snake.add([snake.first[0], snake.first[1] + 3]); // Snake body
    snake.add([snake.first[0], snake.first[1] + 4]); // Snake body

    createFood();

    isPlaying = true;
  }

  Timer createPeriodicTimer(Duration duration) {
    return Timer.periodic(duration, (Timer timer) {
      moveSnake();
      if (duration.inMilliseconds != timeRefreshPage) {
        timer.cancel();
        return createPeriodicTimer(Duration(milliseconds: timeRefreshPage));
      }
      if (checkGameOver()) {
        timer.cancel();
        endGame();
      }
    });
  }

  void moveSnake() {
    setState(() {
      switch (direction) {
        case UP:
          snake.insert(0, [snake.first[0], snake.first[1] - 1]);
          break;

        case DOWN:
          snake.insert(0, [snake.first[0], snake.first[1] + 1]);
          break;

        case LEFT:
          snake.insert(0, [snake.first[0] - 1, snake.first[1]]);
          break;

        case RIGHT:
          snake.insert(0, [snake.first[0] + 1, snake.first[1]]);
          break;
      }

      if (snake.first[0] != food[0] || snake.first[1] != food[1]) {
        snake.removeLast();
      } else {
        createFood();
        timeRefreshPage =
            timeRefreshPage - 10; //this increase the speed of the character
        speed = speed + 10;
      }
    });
  }

  void createFood() {
    food = [
      randomGen.nextInt(SQUARES_PER_ROW),
      randomGen.nextInt(SQUARES_PER_COL)
    ];
  }

  bool checkGameOver() {
    if (!isPlaying ||
        snake.first[0] < 0 //head x
        ||
        snake.first[0] >= SQUARES_PER_ROW ||
        snake.first[1] < 0 //head y
        ||
        snake.first[1] >= SQUARES_PER_COL) {
      return true;
    }

    for (var i = 1; i < snake.length; ++i) {
      if (snake[i][0] == snake.first[0] && snake[i][1] == snake.first[1]) {
        return true;
      }
    }

    return false;
  }

  void endGame() {
    isPlaying = false;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _buildEndGameAlertDialog(context);
        });
  }

  AlertDialog _buildEndGameAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Game Over')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Speed: ${speed}',
            style: fontStyle,
          ),
          Text(
            'Score: ${snake.length - 5}',
            style: fontStyle,
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Close',
            style: TextStyle(color: COLOR_THEME_DARK),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
