// To parse this JSON data, do
//
//     final searchMoviesResponse = searchMoviesResponseFromMap(jsonString);

import 'dart:convert';
import 'package:pelicolas/models/models.dart';

class RespuestaBusqueda {
    RespuestaBusqueda({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Pelicola> results;
    int totalPages;
    int totalResults;

    factory RespuestaBusqueda.fromJson(String str) => RespuestaBusqueda.fromMap(json.decode(str));

    factory RespuestaBusqueda.fromMap(Map<String, dynamic> json) => RespuestaBusqueda(
        page: json["page"],
        results: List<Pelicola>.from(json["results"].map((x) => Pelicola.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}

