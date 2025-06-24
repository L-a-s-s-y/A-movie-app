
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pelicolas/helpers/debouncer.dart';
import 'package:pelicolas/models/models.dart';
import 'package:pelicolas/models/search_movies_response.dart';

class ProveedorPelicolas extends ChangeNotifier{

  String _apiKey= '';
  String _baseURL= 'api.themoviedb.org';
  String _language= 'es-ES';

  List<Pelicola> onDisplayPelicolas= [];
  List<Pelicola> popularesPelicolas= [];
  Map<int, List<Elenco>> elencoPelicola= {};

  int _popularesPagina= 0;

  final Debouncer debouncer= Debouncer(
    duration: Duration(milliseconds: 500),
  );

  final StreamController<List<Pelicola>> _controladorStreamSugerencias= new StreamController.broadcast();

  Stream<List<Pelicola>> get streamSugerencias=>this._controladorStreamSugerencias.stream;

  ProveedorPelicolas(){
    print('MoviesProvider inicializado');
    this.getOnDisplayPelicolas();
    this.getPopularesPelicolas();
  }

  Future<String> _getJsonData(String endpoint, [int page= 1]) async{
    final url = Uri.https(this._baseURL, endpoint, {
      'api_key': this._apiKey,
      'language': this._language,
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayPelicolas() async {
    final jsonData= await this._getJsonData('3/movie/now_playing');
    final respuestaConFormato= RespuestaActuales.fromJson(jsonData);

    this.onDisplayPelicolas= respuestaConFormato.results;
    notifyListeners();
  }

  getPopularesPelicolas() async{
    this._popularesPagina++;
    final jsonData= await this._getJsonData('3/movie/popular',this._popularesPagina);
    final respuestaPopulares= RespuestaPopulares.fromJson(jsonData);
    this.popularesPelicolas= [ ...popularesPelicolas, ...respuestaPopulares.results ];

    notifyListeners();
  }

  Future<List<Elenco>> getElencoPelicola( int pelicolaID ) async{
    if(elencoPelicola.containsKey(pelicolaID)){
      return elencoPelicola[pelicolaID]!;
    }

    final jsonData= await this._getJsonData('3/movie/$pelicolaID/credits');

    final respuestaCreditos= RespuestaCreditos.fromJson(jsonData);

    elencoPelicola[pelicolaID]= respuestaCreditos.cast;
    return respuestaCreditos.cast;
  }
  

  Future<List<Pelicola>> buscarPelicolas(String query) async{

    final url = Uri.https(this._baseURL, '3/search/movie', {
      'api_key': this._apiKey,
      'language': this._language,
      'query': query
    });

    final respuesta = await http.get(url);
    final respuestaBusqueda= RespuestaBusqueda.fromJson(respuesta.body);

    return respuestaBusqueda.results;
  }

  void getSugerenciasPorQuery (String termino){

    debouncer.value='';
    debouncer.onValue= (value) async{
      //print('MOVIES PROVIDER: Habemus valor: ${value}');
      final results= await this.buscarPelicolas(value);
      this._controladorStreamSugerencias.add(results);
    };

    final timer= Timer.periodic(Duration(milliseconds: 300), ( _ ) {
      debouncer.value= termino;
    }); 

    Future.delayed(Duration(milliseconds: 301)).then(( _ ) => timer.cancel());
  }

}