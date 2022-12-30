import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profilecard/Exercice1/providers/QuestionProvider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizzPageWithProvider extends StatefulWidget {
  const QuizzPageWithProvider({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<QuizzPageWithProvider> createState() => SomeQuizzPageState();
}

class SomeQuizzPageState extends State<QuizzPageWithProvider> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 70, top: 6, left: 50, right: 50),
                  child: Image.asset("images/worldcup.jpg", width: 300,
                    height: 200,
                    fit: BoxFit.cover,),
                ),
                Container(
                    width: 300,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.white24,
                        )),
                    child: Center(
                        child: Consumer<QuestionProvider>(
                          builder: (context, provider, child) {
                            return Text(
                              provider.questions[provider.questionNumber]
                                  .questionText,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ))),

                Container(
                    padding: EdgeInsets.only(top: 80),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Consumer<QuestionProvider>(
                              builder: (context, provider, child) {
                                return Padding(
                                    padding: EdgeInsets.all(20),
                                    child: ButtonTheme(
                                        minWidth: 60.0,
                                        height: 35.0,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty
                                                .all(Colors.blueGrey),),
                                          onPressed: () {
                                            provider.countClick++;
                                            if (provider.countClick == 1) {
                                              provider.checkAnswer(
                                                  true, context);
                                            }
                                          },
                                          child: const Text(
                                            "VRAI", style: TextStyle(
                                              color: Colors.white),),
                                        )));
                              }),

                          Consumer<QuestionProvider>(
                              builder: (context, provider, child) {
                                return Padding(
                                    padding: EdgeInsets.all(20),
                                    child: ButtonTheme(
                                        minWidth: 60.0,
                                        height: 35.0,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty
                                                .all(Colors.blueGrey),),
                                          onPressed: () {
                                            provider.countClick++;
                                            if (provider.countClick == 1) {
                                              provider.checkAnswer(
                                                  false, context);
                                            }
                                          },
                                          child: const Text(
                                            "FAUX", style: TextStyle(
                                              color: Colors.white),),
                                        )
                                    ));
                              }),

                          Consumer<QuestionProvider>(
                              builder: (context, provider, child) {
                                return Padding(
                                    padding: EdgeInsets.all(20),
                                    child: ButtonTheme(
                                        minWidth: 60.0,
                                        height: 35.0,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty
                                                .all(Colors.blueGrey),),
                                          onPressed: () {
                                            if (provider.countClick > 0 &&
                                                provider.questionNumber <
                                                    provider.numberQuestions) {
                                              provider.countClick = 0;
                                              provider.nextQuestion();
                                            }

                                            if (provider.isFinished) {
                                              Alert(
                                                  context: context,
                                                  title: "Fin du quizz",
                                                  desc: "Votre score est : ${provider
                                                      .totalRightAnswers}/${provider
                                                      .numberQuestions} !",
                                                  buttons: [
                                                    DialogButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "Rejouer",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 22)))
                                                  ]).show();

                                              provider.reset();
                                            }
                                          },
                                          child: const Icon(
                                              Icons.arrow_forward),
                                        )
                                    ));
                              }
                          )
                        ]

                    )),
                Consumer<QuestionProvider>(
                    builder: (context, provider, child) {
                      return Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: provider.scoreKeeper,));
                    })
              ])),

      backgroundColor: Colors.blueGrey,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}