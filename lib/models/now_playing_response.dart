// To parse this JSON data, do
//
//     final respuesta = respuestaFromMap(jsonString);

import 'dart:convert';
import 'models.dart';

class RespuestaActuales {
    RespuestaActuales({
        required this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    Dates dates;
    int page;
    List<Pelicola> results;
    int totalPages;
    int totalResults;

    factory RespuestaActuales.fromJson(String str) => RespuestaActuales.fromMap(json.decode(str));


    factory RespuestaActuales.fromMap(Map<String, dynamic> json) => RespuestaActuales(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<Pelicola>.from(json["results"].map((x) => Pelicola.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}

class Dates {
    Dates({
        required this.maximum,
        required this.minimum,
    });

    DateTime maximum;
    DateTime minimum;

    factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

    //String toJson() => json.encode(toMap());

    factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    );
}



