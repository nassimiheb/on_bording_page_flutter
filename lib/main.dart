import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  int _slideIndex = 0;

  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  final List<String> images = [
    "assets/iterface1.jpg",
    "assets/interface2.jpg",
    "assets/interface3.jpg",
    "assets/interface4.jpg"
  ];

  List<Color> colors = [Colors.orange];

  final List<String> text0 = [
    "Welcome",
    "THIS IS GI",
    "EVERYTHING",
    "ENJOY"
  ];
  final List<String> text1 = [
    "To CSE's members management app. \n we'll ensure that you will get a memorable experience. a limitless one",
    "It's a mobile app. made to maintain the good and well organized internal members management of the CSE!",
    "Everything you need, in one place: Events,reunions,decisions and more stuff, so you will never come late, you won't miss any sticker, not anymore!",
    "It had been made by CSE's members with so much love, for CSE members"
  ];
final List<Color> backcolors = [
  Colors.blue,Colors.grey[370],Colors.blue,Colors.grey[370]
];
final List<Color> textcolors = [
  Colors.white,Colors.blue,Colors.white,Colors.blue
];
  final IndexController controller = IndexController();
  @override
  Widget build(BuildContext context) {
    TransformerPageView transformerPageView = TransformerPageView(
        pageSnapping: true,
        onPageChanged: (index) {
          setState(() {
            this._slideIndex = index;
          });

          switch (index) {
            case 2:
              {
                print('Last slide :$index');

                // AppInfo.disableWelcomePage();

                // return Timer(Duration(seconds: 3),
                //     () => Navigator.pushNamed(context, '/'));
              }
          }
        },
        loop: false,
        controller: controller,
        transformer: new PageTransformerBuilder(
            builder: (Widget child, TransformInfo info) {
          return new Material(
            elevation: 8.0,
            textStyle: new TextStyle(color: Colors.white),
            borderRadius: new BorderRadius.circular(12.0),
            child: new Container(
              alignment: Alignment.center,
              color: backcolors[info.index],
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 35.0,
                    ),
                    new ParallaxContainer(
                      child :ClipRRect(borderRadius: BorderRadius.circular(130.0),
                      child: Image.asset(
                        images[info.index],
                        fit: BoxFit.contain,
                        height: 248,)
                        ),
                      /*child: new Image.asset(
                        images[info.index],
                        fit: BoxFit.contain,
                        height: 248,
                      ),*/
                      position: info.position,
                      translationFactor: 400.0,
                    ),
                    SizedBox(
                      height: 45.0,
                    ),
                    new ParallaxContainer(
                      child: new Text(
                        text0[info.index],
                        style: new TextStyle(
                            color: textcolors[info.index],
                            fontSize: 34.0,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                      position: info.position,
                      opacityFactor: .8,
                      translationFactor: 400.0,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    new ParallaxContainer(
                      child: new Text(
                        text1[info.index],
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: textcolors[info.index],
                            fontSize: 14.0,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                      position: info.position,
                      translationFactor: 300.0,
                    ),
                    SizedBox(
                      height: 55.0,
                    ),
                    new ParallaxContainer(
                      position: info.position,
                      translationFactor: 500.0,
                      child: Dots(
                        controller: controller,
                        slideIndex: _slideIndex,
                        numberOfDots: images.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
        itemCount: 4);

    return Scaffold(
      backgroundColor: Colors.white,
      body: transformerPageView,
    );
  }
}

class Dots extends StatelessWidget {
  final IndexController controller;
  final int slideIndex;
  final int numberOfDots;
  final List<Color> dotColors = [
  Colors.white,Colors.blue,Colors.white,Colors.blue
];

  Dots({this.controller, this.slideIndex, this.numberOfDots});

  List<Widget> _generateDots() {
    List<Widget> dots = [];
    for (int i = 0; i < numberOfDots; i++) {
      dots.add(i == slideIndex ? _activeSlide(i) : _inactiveSlide(i));
    }

    return dots;
  }

  Widget _activeSlide(int index) {
    return GestureDetector(
      onTap: () {
        print('Tapped');
      },
      child: new Container(
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              color: dotColors[slideIndex].withOpacity(.3),
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inactiveSlide(int index) {
    return GestureDetector(
      onTap: () {        
        controller.move(index);
      },
      child: new Container(
        child: Padding(
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          child: Container(
            width: 14.0,
            height: 14.0,
            decoration: BoxDecoration(
                color: dotColors[slideIndex].withOpacity(0.7),
                borderRadius: BorderRadius.circular(50.0)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _generateDots(),
    ));
  }
}
