import 'dart:convert';

IncidenteModel incidenteModelFromJson(String str) =>
    IncidenteModel.fromJson(json.decode(str));

String incidenteModelToJson(IncidenteModel data) => json.encode(data.toJson());

class IncidenteModel {
  String id;
  String titulo;
  String descripcion;
  int createdAt;
  int updatedAt;
  String fotoUrl;

  IncidenteModel(
      {this.id,
      this.titulo = '',
      this.descripcion = '',
      this.fotoUrl,
      this.createdAt,
      this.updatedAt});

  factory IncidenteModel.fromJson(Map<String, dynamic> json) =>
      new IncidenteModel(
          id: json["id"],
          titulo: json["titulo"],
          descripcion: json["descripcion"],
          fotoUrl: json["fotoUrl"],
          createdAt: json["createdAt"],
          updatedAt: json["updatedAt"]);

  Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "descripcion": descripcion,
        "fotoUrl": fotoUrl,
        "createdAt": createdAt,
        "updatedAt": updatedAt
      };
}
