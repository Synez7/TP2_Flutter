import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../business_logic/cubits/QuestionCubit.dart';
import '../../business_logic/cubits/QuestionState.dart';

class QuizzPageWithCubit extends StatefulWidget {
  const QuizzPageWithCubit({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<QuizzPageWithCubit> createState() => SomeQuizzPageState();
}

class SomeQuizzPageState extends State<QuizzPageWithCubit> {


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
                        child: BlocBuilder<QuestionCubit,QuestionState>(
                          builder: (context, state) {
                            return Text(
                              state.question.questionText,
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
                          BlocBuilder<QuestionCubit, QuestionState>(
                              builder: (context, state) {
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
                                            context.read<QuestionCubit>().countClick++;
                                            if (context.read<QuestionCubit>().countClick == 1) {
                                              context.read<QuestionCubit>().checkAnswer(
                                                  true, context);
                                            }
                                          },
                                          child: const Text(
                                            "VRAI", style: TextStyle(
                                              color: Colors.white),),
                                        )));
                              }),

                          BlocBuilder<QuestionCubit, QuestionState>(
                              builder: (context, state) {
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
                                            context.read<QuestionCubit>().countClick++;
                                            if (context.read<QuestionCubit>().countClick == 1) {
                                              context.read<QuestionCubit>().checkAnswer(
                                                  false, context);
                                            }
                                          },
                                          child: const Text(
                                            "FAUX", style: TextStyle(
                                              color: Colors.white),),
                                        )
                                    ));
                              }),

                          BlocBuilder<QuestionCubit, QuestionState>(
                              builder: (context, state) {
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
                                            if (context.read<QuestionCubit>().countClick > 0 &&
                                                context.read<QuestionCubit>().questionNumber <
                                                    context.read<QuestionCubit>().numberQuestions) {
                                              context.read<QuestionCubit>().countClick = 0;
                                              context.read<QuestionCubit>().nextQuestion();
                                            }

                                            if (context.read<QuestionCubit>().isFinished) {
                                              Alert(
                                                  context: context,
                                                  title: "Fin du quizz",
                                                  desc: "Votre score est : ${context.read<QuestionCubit>().totalRightAnswers}/"
                                                      "${context.read<QuestionCubit>().numberQuestions} !",
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

                                              context.read<QuestionCubit>().reset();


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
                BlocBuilder<QuestionCubit, QuestionState>(
                    builder: (context, state) {
                      return Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: context.read<QuestionCubit>().scoreKeeper,));
                    })
              ])),

      backgroundColor: Colors.blueGrey,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}