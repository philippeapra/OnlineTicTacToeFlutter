import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  runApp(MyApp(),);
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: MyFirstPage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}
class MyFirstPage extends StatefulWidget {
  MyFirstPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyFirstPageState createState() => _MyFirstPageState();
}
class _MyFirstPageState extends State<MyFirstPage> {
  @override
  void initState() {
    super.initState();}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('XOonline')),
      body: Center(
        child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder:(context)=>new MyHomePage(0,'home') )
                  );
                },
                child: Text('Multiplayer'),
              ),
              RaisedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder:(context)=>new MyCreateRoomLoadingPage(title: 'Create Room') )
                  );
                },
                child: Text('Create room'),
              ),
              RaisedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder:(context)=>new MyJoinRoomPage(title: 'Join Room') )
                  );
                },
                child: Text('Join room'),
              ),
            ]

        ),


      )
    );
  }
}
class MyHomePage extends StatefulWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  int RoomCode =0;
  MyHomePage(this.RoomCode, this.title);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // if (snapshot.hasError) {
        //   return SomethingWentWrong();
        // }
        if (snapshot.connectionState == ConnectionState.done) {
          //return MyApp();
        }
        return MyApp();
        // Otherwise, show something whilst waiting for initialization to complete
        //return Loading();
      },
    );
  }
  //MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(RoomCode);
}
class _MyHomePageState extends State<MyHomePage> {
  int RoomCode;
  _MyHomePageState(this.RoomCode);
  late final dref = FirebaseDatabase.instance.reference();
  int _counter = 0;
  String nameval="bla";
  String TVtxt = "";
  String Btn1txt = "";
  String Btn2txt = "";
  String Btn3txt = "";
  String Btn4txt = "";
  String Btn5txt = "";
  String Btn6txt = "";
  String Btn7txt = "";
  String Btn8txt = "";
  String Btn9txt = "";
  bool XTurn = true;
  bool Btn1Enabled = true;
  bool Btn2Enabled = true;
  bool Btn3Enabled = true;
  bool Btn4Enabled = true;
  bool Btn5Enabled = true;
  bool Btn6Enabled = true;
  bool Btn7Enabled = true;
  bool Btn8Enabled = true;
  bool Btn9Enabled = true;
  int Btn1ID = 1;
  int Btn2ID = 2;
  int Btn3ID = 3;
  int Btn4ID = 4;
  int Btn5ID = 5;
  int Btn6ID = 6;
  int Btn7ID = 7;
  int Btn8ID = 8;
  int Btn9ID = 9;
  int LastBtnPressed=0;

  void EndGame(){
    Btn1Enabled = false;
    Btn2Enabled = false;
    Btn3Enabled = false;
    Btn4Enabled = false;
    Btn5Enabled = false;
    Btn6Enabled = false;
    Btn7Enabled = false;
    Btn8Enabled = false;
    Btn9Enabled = false;
    //Navigator.pop(context);

  }
  String CheckWin(){
    _counter++;
    String TVtextz = "";
    if(_counter>4){
      if (Btn1txt!=""&&Btn1txt==Btn2txt&& Btn2txt==Btn3txt){
        TVtextz = Btn1txt+" wins";
        EndGame();
      }

      else if (Btn7txt!=""&&Btn7txt==Btn8txt&& Btn8txt==Btn9txt){
        TVtextz = Btn7txt+" wins";
        EndGame();
      }
      else if (Btn1txt!=""&&Btn1txt==Btn4txt&& Btn4txt==Btn7txt){
        TVtextz = Btn1txt+" wins";
        EndGame();
      }
      else if (Btn3txt!=""&&Btn3txt==Btn6txt&& Btn6txt==Btn9txt){
        TVtextz = Btn3txt+" wins";
        EndGame();
      }
      else if (Btn4txt!=""&&Btn4txt==Btn5txt&& Btn5txt==Btn6txt){
        TVtextz = Btn4txt+" wins";
        EndGame();
      }

      else if (Btn2txt!=""&&Btn2txt==Btn5txt&& Btn5txt==Btn8txt){
        TVtextz = Btn2txt+" wins";
        EndGame();
      }

      else if (Btn1txt!=""&&Btn1txt==Btn5txt&& Btn5txt==Btn9txt){
        TVtextz = Btn1txt+" wins";
        EndGame();
      }
      else if (Btn3txt!=""&&Btn3txt==Btn5txt&& Btn5txt==Btn7txt){
        TVtextz = Btn3txt+" wins";
        EndGame();
      }
      else if (Btn1txt!=""&&Btn2txt!=""&&Btn3txt!=""&&Btn4txt!=""&&Btn5txt!=""&&Btn6txt!=""&&Btn7txt!=""&&Btn8txt!=""&&Btn9txt!=""){
        TVtextz = "Draw";
        //EndGame();
      }
    }


    return TVtextz;
  }

  String ChangeBtnText (int BtnID,String BtnText,bool BtnEnabled){
    if (BtnEnabled) {
      if (!XTurn) {
        BtnText = "O";
        XTurn = true;
        dref.child(RoomCode.toString()).update(
            {
              "$BtnID":"O",
              "XTurn":true
            }
        );
      }
      else {
        BtnText = "X";
        XTurn = false;
        dref.child(RoomCode.toString()).update(
            {
              "$BtnID":"X",
              "XTurn":false
            }
        );
      }
    }
    return BtnText;
  }
  void Restart(){
    //Phoenix.rebirth(context);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder:(context)=>new MyHomePage(RoomCode,'home') )
    );
  }

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    dref.child(RoomCode.toString()).set({
      "1": "",
      "2": "",
      "3": "",
      "4": "",
      "5": "",
      "6": "",
      "7": "",
      "8": "",
      "9": "",
      "XTurn":true
    }
    );
    dref.child(RoomCode.toString()).onChildChanged.forEach((event) {

      if(event.snapshot.key == 'XTurn'){setState(() {XTurn=event.snapshot.value;});}
      if (event.snapshot.key == '1'){
        setState(() {Btn1txt=event.snapshot.value .toString();});
        if (LastBtnPressed!=1){
          setState(() {TVtxt = CheckWin();});
        }
      }
      if (event.snapshot.key == '2'){
        setState(() {Btn2txt=event.snapshot.value .toString();});
        if (LastBtnPressed!=2){
          setState(() {TVtxt = CheckWin();});
        }
      }
      if (event.snapshot.key == '3'){
        setState(() {Btn3txt=event.snapshot.value .toString();});
        if (LastBtnPressed!=3){
          setState(() {TVtxt = CheckWin();});
        }
        //setState(() {});
      }
      if (event.snapshot.key == '4'){
        setState(() {Btn4txt=event.snapshot.value .toString();});
        if (LastBtnPressed!=4){
          setState(() {TVtxt = CheckWin();});
        }
      }
      if (event.snapshot.key == '5'){
        setState(() {Btn5txt=event.snapshot.value .toString();});
        if (LastBtnPressed!=5){
          setState(() {TVtxt = CheckWin();});
        }
      }
      if (event.snapshot.key == '6'){
        setState(() {Btn6txt=event.snapshot.value .toString();});
        if (LastBtnPressed!=6){
          setState(() {TVtxt = CheckWin();});
        }
      }
      if (event.snapshot.key == '7'){
        setState(() {Btn7txt=event.snapshot.value .toString();});
        if (LastBtnPressed!=7){
          setState(() {TVtxt = CheckWin();});
        }
      }
      if (event.snapshot.key == '8'){
        setState(() {Btn8txt=event.snapshot.value .toString();});
        if (LastBtnPressed!=8){
          setState(() {TVtxt = CheckWin();});
        }
      }
      if (event.snapshot.key == '9'){
        setState(() {Btn9txt=event.snapshot.value .toString();});
        if (LastBtnPressed!=9){
          setState(() {TVtxt = CheckWin();});
        }
      }

      //event.snapshot.key.toString():event.snapshot.value .toString()
      //"1":"", "2":"", '3':"", '4':"", '5':"", '6':"", '7':"", '8':"", '9':""

    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
       appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
         title: Text(widget.title),
       ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                              color: Colors.orange,
                              width: 9,
                            ),
                            bottom: BorderSide(
                              color: Colors.orange,
                              width: 9,
                            ))),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 40),
                      ),
                      child:Text(Btn1txt),//1
                      onPressed: () {
                        setState(() {
                          LastBtnPressed = 1;
                          Btn1txt = ChangeBtnText(Btn1ID,Btn1txt,Btn1Enabled);
                          Btn1Enabled = false;
                          TVtxt = CheckWin();
                        });
                      },

                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: Colors.orange,
                              width: 9,
                            ))),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 40),
                      ),
                      child:   Text(Btn2txt),//2
                      onPressed: () {
                        setState(() {
                          LastBtnPressed = 2;
                          Btn2txt = ChangeBtnText(Btn2ID,Btn2txt,Btn2Enabled);
                          Btn2Enabled = false;
                          TVtxt = CheckWin();
                        });
                      },

                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                              color: Colors.orange,
                              width: 9,
                            ),
                            bottom: BorderSide(
                              color: Colors.orange,
                              width: 9,
                            ))),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 40),
                      ),
                      child:   Text(Btn3txt),//3
                      onPressed: () {
                        setState(() {
                          LastBtnPressed = 3;
                          Btn3txt = ChangeBtnText(Btn3ID,Btn3txt,Btn3Enabled);
                          Btn3Enabled = false;
                          TVtxt = CheckWin();
                        });

                      },

                    ),
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.orange,
                            width: 9,
                          ),
                        )),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 40),
                      ),
                      child:   Text(Btn4txt),//4
                      onPressed: () {
                        setState(() {
                          LastBtnPressed = 4;
                          Btn4txt = ChangeBtnText(Btn4ID,Btn4txt,Btn4Enabled);
                          Btn4Enabled = false;
                          TVtxt = CheckWin();
                        });

                      },

                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,


                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 40),
                      ),
                      child:   Text(Btn5txt),//5
                      onPressed: () {
                        setState(() {
                          LastBtnPressed = 5;
                          Btn5txt = ChangeBtnText(Btn5ID,Btn5txt,Btn5Enabled);
                          Btn5Enabled = false;
                          TVtxt = CheckWin();
                        });

                      },

                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.orange,
                            width: 9,
                          ),
                        )),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 40),
                      ),
                      child:   Text(Btn6txt),//6
                      onPressed: () {
                        setState(() {
                          LastBtnPressed = 6;
                          Btn6txt = ChangeBtnText(Btn6ID,Btn6txt,Btn6Enabled);
                          Btn6Enabled = false;
                          TVtxt = CheckWin();
                        });

                      },

                    ),
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                              color: Colors.orange,
                              width: 9,
                            ),
                            top: BorderSide(
                              color: Colors.orange,
                              width: 9,
                            ))),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 40),
                      ),
                      child:   Text(Btn7txt),//7
                      onPressed: () {
                        setState(() {
                          LastBtnPressed = 7;
                          Btn7txt = ChangeBtnText(Btn7ID,Btn7txt,Btn7Enabled);
                          Btn7Enabled = false;
                          TVtxt = CheckWin();
                        });

                      },

                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: Colors.orange,
                              width: 9,
                            ))),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 40),
                      ),
                      child:   Text(Btn8txt),//8
                      onPressed: () {
                        setState(() {
                          LastBtnPressed = 8;
                          Btn8txt = ChangeBtnText(Btn8ID,Btn8txt,Btn8Enabled);
                          Btn8Enabled = false;
                          TVtxt = CheckWin();
                        });

                      },

                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                              color: Colors.orange,
                              width: 9,
                            ),
                            top: BorderSide(
                              color: Colors.orange,
                              width: 9,
                            ))),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 40),
                      ),
                      child:   Text(Btn9txt),//9
                      onPressed: () {
                        setState(() {
                          LastBtnPressed = 9;
                          Btn9txt = ChangeBtnText(Btn9ID,Btn9txt,Btn9Enabled);
                          Btn9Enabled = false;
                          TVtxt = CheckWin();
                        });

                      },

                    ),
                  ),
                ]
            ),
            // TextField(
            //   controller: _controller,
            //
            //   onSubmitted: (String value) async {
            //     nameval=value;
            //     // await showDialog<void>(
            //     //   context: context,
            //     //   builder: (BuildContext context) {
            //     //     return AlertDialog(
            //     //       title: const Text('Thanks!'),
            //     //       content: Text(
            //     //           'You typed "$value", which has length ${value.characters.length}.'),
            //     //       actions: <Widget>[
            //     //         TextButton(
            //     //           onPressed: () {
            //     //             Navigator.pop(context);
            //     //           },
            //     //           child: const Text('OK'),
            //     //         ),
            //     //       ],
            //     //     );
            //     //   },
            //     // );
            //   },
            // ),
            // Text(
            //   'You have pushed the button this many times:',
            // ),
            Text(
              TVtxt,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Restart,
        tooltip: 'Restart',
        child: Icon(Icons.restart_alt_rounded),

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class MyCreateRoomLoadingPage extends StatefulWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // if (snapshot.hasError) {
        //   return SomethingWentWrong();
        // }
        if (snapshot.connectionState == ConnectionState.done) {
          //return MyApp();
        }
        return MyApp();
        // Otherwise, show something whilst waiting for initialization to complete
        //return Loading();
      },
    );
  }
  MyCreateRoomLoadingPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyCreateRoomLoadingPageState createState() => _MyCreateRoomLoadingPageState();
}
class _MyCreateRoomLoadingPageState extends State<MyCreateRoomLoadingPage> {
  late final dref = FirebaseDatabase.instance.reference();
  var roomcode = new Random().nextInt(900000)+100000;
  //var roomcode = random.nextInt(90) + 10; // from 0 upto 99 included
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
            body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Room code: $roomcode"),
                  Text("Waiting for opponent to join the room."),
                  Text("Please wait..."),
                ]
            ),
          ),
        );

  }
}
class MyJoinRoomPage extends StatefulWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // if (snapshot.hasError) {
        //   return SomethingWentWrong();
        // }
        if (snapshot.connectionState == ConnectionState.done) {
          //return MyApp();
        }
        return MyApp();
        // Otherwise, show something whilst waiting for initialization to complete
        //return Loading();
      },
    );
  }
  MyJoinRoomPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyJoinRoomPageState createState() => _MyJoinRoomPageState();
}
class _MyJoinRoomPageState extends State<MyJoinRoomPage> {
  late final dref = FirebaseDatabase.instance.reference();
  TextEditingController _controller = new TextEditingController();
  int RoomCode = 0;
  void GoToRoom(){
    showAlertDialog(BuildContext context) {

      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("My title"),
        content: Text("This is my message."),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    showAlertDialog(context);
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter room code",
                  //errorText: _validate ? 'Value Can\'t Be Empty' : null,
                ),
                maxLength: 6,
                keyboardType: TextInputType.phone,
                controller: _controller,
                onSubmitted: (String value) async {
                  RoomCode= value as int;

                  // await showDialog<void>(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return AlertDialog(
                  //       title: const Text('Thanks!'),
                  //       content: Text(
                  //           'waiting for opponent to enter the room. Please wait...'),
                  //       actions: <Widget>[
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.pop(context);
                  //           },
                  //           child: const Text('Submit'),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // );
                },

              ),
              TextButton(
                  onPressed: (){
                    setState(() {
                      _controller.text.isEmpty ? null : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder:(context)=>new MyHomePage(int.tryParse(_controller.text) ?? 0, 'home') )
                      );
                    });

                  },
                  child: Text("Play!")
              )
            ]
        ),
      ),
    );
  }
}
// Navigator.push(
// context,
// MaterialPageRoute(
// builder:(context)=>MyApp() )
// );




