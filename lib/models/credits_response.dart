// To parse this JSON data, do
//
//     final creditsResponse = creditsResponseFromMap(jsonString);

import 'dart:convert';

class RespuestaCreditos {
    RespuestaCreditos({
        required this.id,
        required this.cast,
        required this.crew,
    });

    int id;
    List<Elenco> cast;
    List<Elenco> crew;

    factory RespuestaCreditos.fromJson(String str) => RespuestaCreditos.fromMap(json.decode(str));

    //String toJson() => json.encode(toMap());

    factory RespuestaCreditos.fromMap(Map<String, dynamic> json) => RespuestaCreditos(
        id: json["id"],
        cast: List<Elenco>.from(json["cast"].map((x) => Elenco.fromMap(x))),
        crew: List<Elenco>.from(json["crew"].map((x) => Elenco.fromMap(x))),
    );

}

class Elenco {
    Elenco({
        required this.adult,
        required this.gender,
        required this.id,
        required this.knownForDepartment,
        required this.name,
        required this.originalName,
        required this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        required this.creditId,
        this.order,
        this.department,
        this.job,
    });

    bool adult;
    int gender;
    int id;
    String knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String? profilePath;
    int? castId;
    String? character;
    String creditId;
    int? order;
    String? department;
    String? job;

    get fullProfilePath{
      if(this.profilePath!=null)
        return 'https://image.tmdb.org/t/p/w500${this.profilePath}';
      return 'https://i.stack.imgur.com/GNhxO.png';
    }

    factory Elenco.fromJson(String str) => Elenco.fromMap(json.decode(str));


    factory Elenco.fromMap(Map<String, dynamic> json) => Elenco(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        castId: json["cast_id"] == null ? null : json["cast_id"],
        character: json["character"] == null ? null : json["character"],
        creditId: json["credit_id"],
        order: json["order"] == null ? null : json["order"],
        department: json["department"] == null ? null : json["department"],
        job: json["job"] == null ? null : json["job"],
    );
}
