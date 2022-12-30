import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Exercice1/presentation/screens/QuizzPageWithProvider.dart';
import 'Exercice2/presentation/screens/QuizzPageWithCubit.dart';
import 'WeatherApp/presentation/screens/home_page.dart';


// Classe utilisée pour la création d'un dashboard composé de Cards pour chacun des exercices du TP2
class GridDashboard extends StatelessWidget {

  Items item1 = new Items(
      title: "Exercice 1",
      subtitle: "Utilisation du Provider",
      img: "images/logo.jpg"
  );

  Items item2 = new Items(
    title: "Exercice 2",
    subtitle: "Utilisation du Bloc/Cubit",
    img: "images/bloc.png",
  );

  Items item3 = new Items(
    title: "Exercice 3",
    subtitle: "Création d’application Météo",
    img: "images/weather.png",
  );

  static bool exo1 = false;
  static bool exo2 = false;


  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3];
    var color = 0xff64517c;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return Container(
              decoration: BoxDecoration(
                  color: Color(color), borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff6f2da8),
                    blurRadius: 10.0,
                    offset: Offset(
                      3.0, // Move to right 5  horizontally
                      3.0, // Move to bottom 5 Vertically
                    ),
                  )
                ],),
                  child: GestureDetector(
                    onTap: (){
                      if(data.title == "Exercice 1"){
                        exo1 = true;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QuizzPageWithProvider(title: "Questions/Réponses (PROVIDER)")));
                      }

                      if(data.title == "Exercice 2"){
                        exo2 = true;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QuizzPageWithCubit(title: "Questions/Réponses (CUBIT)")));
                      }

                      if(data.title == "Exercice 3"){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                      }
                      },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          data.img,
                          width: 55,
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          data.title,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          data.subtitle,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                );
            }).toList()),


    );
  }
}

class Items {
  String title;
  String subtitle;
  String img;
  Items({required this.title, required this.subtitle, required this.img});
}
