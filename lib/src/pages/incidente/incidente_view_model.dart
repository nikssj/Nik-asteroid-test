import 'package:asteroid_test/src/apis/incidentes_api.dart';
import 'package:asteroid_test/src/core/providers/base_model.dart';
import 'package:asteroid_test/src/models/incidente_model.dart';

class IncidenteViewModel extends BaseModel {
  List<IncidenteModel> _listaIncidentes = <IncidenteModel>[];

  List<IncidenteModel> get listaIncidentes => _listaIncidentes;

  set setListaIncidentes(List<IncidenteModel> listaIncidentes) {
    _listaIncidentes = listaIncidentes;
  }

  Future<bool> crearIncidente(IncidenteModel incidente) async {
    bool flag = await canCreateIncident(incidente, false);

    if (flag) {
      await incidentesApi.crearIncidente(incidente);

      print('Creado correctamente');
      return true;
    }
    return false;
  }

  Future<bool> modificarIncidente(IncidenteModel incidente) async {
    bool flag = await canCreateIncident(incidente, true);

    if (flag) {
      await incidentesApi.editarIncidente(incidente);

      print('Modificado correctamente');

      return true;
    }
    return false;
  }

  Future<void> borrarIncidente(IncidenteModel incidente) async {
    await incidentesApi.borrarIncidente(incidente.id);

    print('Modificado correctamente');
  }

  Future<void> cargarIncidentes() async {
    setListaIncidentes = await incidentesApi.cargarIncidentes();
  }

  Future<bool> canCreateIncident(
      IncidenteModel incidente, bool isModifying) async {
    await cargarIncidentes();

    final hastMatch = _listaIncidentes
        .firstWhere((a) => a.titulo == incidente.titulo, orElse: () {
      print('Titulo correcto. No hay coincidencias');
      return;
    });

    if (isModifying) {
      if (hastMatch != null && hastMatch.id != incidente.id) {
        print('Existen coincidencias. No se puede modificar titulo');

        return false;
      }
    } else {
      if (hastMatch != null) {
        print('Existen coincidencias. No se puede crear el titulo');
        return false;
      }
    }

    return true;
  }
}
