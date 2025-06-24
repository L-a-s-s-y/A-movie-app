// To parse this JSON data, do
//
//     final popularResponse = popularResponseFromMap(jsonString);

import 'dart:convert';

import 'package:pelicolas/models/models.dart';

class RespuestaPopulares {
    RespuestaPopulares({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Pelicola> results;
    int totalPages;
    int totalResults;

    factory RespuestaPopulares.fromJson(String str) => RespuestaPopulares.fromMap(json.decode(str));

    //String toJson() => json.encode(toMap());

    factory RespuestaPopulares.fromMap(Map<String, dynamic> json) => RespuestaPopulares(
        page: json["page"],
        results: List<Pelicola>.from(json["results"].map((x) => Pelicola.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}