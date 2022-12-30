import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Cercle de chargement affiché lors de l'attente d'une réponse pour la requête
// liée aux forecasts

class LoadingWidget extends StatelessWidget {

  LoadingWidget(this.height);

  double height;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}