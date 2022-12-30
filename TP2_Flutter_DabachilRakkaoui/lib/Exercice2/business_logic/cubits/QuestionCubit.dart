import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/Question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'QuestionState.dart';

class QuestionCubit extends Cubit<QuestionState> {

  final List<Question> _questions = [
    Question(questionText: "C'est un Français qui a eu l'idée de créer la Coupe du monde.", isCorrect: true),
    Question(questionText: "Kylian Mbappé est le plus jeune joueur à marquer trois buts en Coupe du monde.", isCorrect: false),
    Question(questionText: "La première édition de la Coupe du monde a eu lieu au Brésil.", isCorrect: false),
    Question(questionText: "L' Allemagne détient le plus grand nombre de participations en Coupe du monde.", isCorrect: false),
    Question(questionText: "Ils étaient 1,12 milliard de téléspectateurs à suivre la finale de la Coupe du monde 2018.", isCorrect: true),
    Question(questionText: "Les Pays-Bas comptent le plus grand nombre de finales perdues.", isCorrect: true),
    Question(questionText: "Le record de buts inscrits en une édition appartient au Brésil.", isCorrect: false),
    Question(questionText: "Le Cameroun est le premier pays africain à atteindre les quarts de finale.", isCorrect: true),
    Question(questionText: "La Corée du Sud a déjà atteint les demi-finales d'un Mondial.", isCorrect: true),
    Question(questionText: "Just Fontaine a inscrit le plus grand nombre de buts en Coupe du monde.", isCorrect: true),
  ];
  final List<Widget> scoreKeeper = [];

  bool _isFinished = false;
  int countClick = 0;
  int _questionNumber = 0;
  int _totalRightAnswers = 0;
  final int _numberQuestions = 10; // nombre de questions du quizz
  late Question _question = Question(questionText: "C'est un Français qui a eu l'idée de créer la Coupe du monde.", isCorrect: true);

  QuestionCubit()
      : super(QuestionState(0,Question(questionText: "C'est un Français qui a eu l'idée de créer la Coupe du monde.", isCorrect: true)));

  List<Question> get questions => _questions;
  bool get isFinished => _isFinished;
  int get questionNumber => _questionNumber;
  int get totalRightAnswers => _totalRightAnswers;
  int get numberQuestions => _numberQuestions;
  Question get question => _question;

  set isFinished(bool number){
    _isFinished = number;
    emit(QuestionState(_questionNumber,_question));
    }



  checkAnswer(bool userChoice, BuildContext context) {
    // Cas d'une réponse correcte choisie par l'utilisateur
    if (questions[_questionNumber].isCorrect == userChoice) {
      _totalRightAnswers = _totalRightAnswers + 1;
      scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
      emit(QuestionState(_questionNumber, _question));

    }
    // Cas contraire
    else {
      scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
      emit(QuestionState(_questionNumber, _question));

    }

  }


  nextQuestion() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
      _question = _questions[_questionNumber];
      emit(QuestionState(_questionNumber, _question));

    } else {
      isFinished = true;
      emit(QuestionState(_questionNumber, _question));
    }

  }

  reset(){
    _questionNumber = 0;
    _question = _questions[_questionNumber];
    emit(QuestionState(_questionNumber, _question));
    _totalRightAnswers = 0;
    countClick = 0;
    _isFinished = false;
    scoreKeeper.clear();


  }


}