import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'Exercice1/providers/QuestionProvider.dart';
import 'Exercice2/business_logic/cubits/QuestionCubit.dart';
import 'Exercice2/presentation/screens/QuizzPageWithCubit.dart';
import 'GridDashboard.dart';
import 'WeatherApp/business_logic/cubits/WeatherCubit.dart';
import 'WeatherApp/presentation/screens/home_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
            providers: [
        ChangeNotifierProvider<QuestionProvider>(create: (BuildContext context) {
          return QuestionProvider();
    }),
    BlocProvider(
    child: const QuizzPageWithCubit(title: 'Questions/Réponses',),
    create: (_) => QuestionCubit()),
              BlocProvider(
                  create: (context) => WeatherCubit(),
                  child: const MyHomePage())
            ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My First Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: !GridDashboard.exo1 ? Home() : BlocProvider(
          child: const QuizzPageWithCubit(title: 'Questions/Réponses',),
          create: (_) => QuestionCubit(),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();

}

class HomeState extends State<Home> {

  // Setup de la configuration des vagues d'animation pour l'interface d'accueil
  static const _backgroundColor = Color(0xff392850);

  // Couleurs associées aux deux vagues d'animation
  static const _colors = [
    Color(0xFF5F4C77),
    Color(0xFF8873A1),
  ];

  static const _durations = [
    5000,
    4000,
  ];

  static const _heightPercentages = [
    0.7,
    0.71,
  ];
  get colors => _colors;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff392850),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 110,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "TP2 - Gestion du state",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Menu d'exercices",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Color(0xffa29aac),
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            height: 70,
          ),
          GridDashboard(),

          WaveWidget(
            config: CustomConfig(
              colors: colors,
              durations: _durations,
              heightPercentages: _heightPercentages,
            ),
            backgroundColor: _backgroundColor,
            size: Size(400, 180),
            waveAmplitude: 0,
          ),

        ],
      ),
    );
  }
}

