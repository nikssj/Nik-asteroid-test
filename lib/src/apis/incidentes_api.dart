import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime_type/mime_type.dart';

import 'package:asteroid_test/src/models/incidente_model.dart';

final incidentesApi = new IncidentesApi();

//ApiService de incidentes

class IncidentesApi {
  //Url Firebase
  final String _url = 'https://nik-asteroid-test-default-rtdb.firebaseio.com';

  Future<bool> crearIncidente(IncidenteModel incidente) async {
    final url = '$_url/incidentes.json';

    final resp =
        await http.post(Uri.parse(url), body: incidenteModelToJson(incidente));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editarIncidente(IncidenteModel incidente) async {
    final url = '$_url/incidentes/${incidente.id}.json';

    final resp =
        await http.put(Uri.parse(url), body: incidenteModelToJson(incidente));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<IncidenteModel>> cargarIncidentes() async {
    final url = '$_url/incidentes.json';
    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<IncidenteModel> incidentes = [];

    if (decodedData == null) return [];

    decodedData.forEach((id, incidente) {
      final incidenteTemp = IncidenteModel.fromJson(incidente);
      incidenteTemp.id = id;

      incidentes.add(incidenteTemp);
    });

    return incidentes;
  }

  Future<void> borrarIncidente(String id) async {
    final url = '$_url/incidentes/$id.json';

    await http.delete(Uri.parse(url));
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dc0tufkzf/image/upload?upload_preset=cwye3brj');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');

      print(resp.body);

      return null;
    }

    final respData = json.decode(resp.body);

    print(respData);

    return respData['secure_url'];
  }
}
