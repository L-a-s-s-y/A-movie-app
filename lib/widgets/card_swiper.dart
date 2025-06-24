import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
//import 'package:flutt';

class CardSwipper extends StatelessWidget {


  final List<Pelicola> filmoteca;

  const CardSwipper({
    Key? key,
    required this.filmoteca
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size= MediaQuery.of(context).size;
    
    if(this.filmoteca.length == 0){
      return Container(
        width: double.infinity,
        height: size.height*0.5,
        child: Center(
          child: CircularProgressIndicator(),
        )
      );
    }

    return Container(
      //child: Swiper,
      
      width: double.infinity,
      height: size.height*0.5, //50%
      //color: Colors.red,
      child: Swiper(
        itemCount: filmoteca.length, //Cantidad de tarjetas que se van a manejar.
        layout: SwiperLayout.STACK, //Tipo de layout, elegir al gusto
        itemWidth: size.width*0.6, //60%
        itemHeight: size.height*0.4, //90%
        itemBuilder: ( _ , int index){

          final pelicola= this.filmoteca[index];
          //print(pelicola.fullCaratulaImg);
          pelicola.heroID='Swiper-${pelicola.id}';
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: pelicola),
            child: Hero(
              tag: pelicola.heroID!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'), 
                    //image: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(pelicola.fullCaratulaPath),
                    fit: BoxFit.cover,
                  ),
              ),
            ),
          );
        } , //Se va a estar contruyendo de manera dinámica o cuando sea necesario. Es una función que se va a disparar para construir el nuevo widget
      ),
    );
  }
}
