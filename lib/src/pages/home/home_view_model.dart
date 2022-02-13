import 'package:asteroid_test/src/apis/incidentes_api.dart';
import 'package:asteroid_test/src/core/providers/base_model.dart';
import 'package:asteroid_test/src/models/incidente_model.dart';

class HomeViewModel extends BaseModel {
  List<IncidenteModel> _listadoIncidentes = <IncidenteModel>[];

  List<IncidenteModel> get listadoIncidentes => _listadoIncidentes;

  set setListadoIncidentes(List<IncidenteModel> listadoIncidentes) {
    _listadoIncidentes = listadoIncidentes;
  }

  //Lista de incidentes duplicado para el Search Bar
  List<IncidenteModel> _listadoIncidentesDuplicated = [];

  List<IncidenteModel> get listadoIncidentesDuplicated =>
      _listadoIncidentesDuplicated;

  set setListadoIncidentesDuplicated(listadoIncidentes) {
    _listadoIncidentesDuplicated = listadoIncidentes;
  }

  //Llamos al getIncidentes de la API

  Future<void> fetchIncidentes() async {
    final resp = await incidentesApi.cargarIncidentes();

    if (resp != null) {
      setListadoIncidentes = resp;
    }
  }

  //Ordenamos por ultima actualizacion del incidente, priorizando las updateAt

  void sortByLastUpdate() {
    _listadoIncidentes.sort((a, b) =>
        (b.updatedAt ?? b.createdAt).compareTo(a.updatedAt ?? a.createdAt));
  }

  //Metodo para refreshear la view
  Future<void> actualizarGrilla() async {
    resetData();

    await fetchIncidentes();

    if (_listadoIncidentes.length > 1) {
      sortByLastUpdate();
    }

    _listadoIncidentesDuplicated.addAll(_listadoIncidentes);

    notifyListeners();
  }

  void filtrarIncidentes(List value) {
    _listadoIncidentes.clear();

    setListadoIncidentes = value;

    notifyListeners();
  }

  void resetData() {
    _listadoIncidentes.clear();

    _listadoIncidentesDuplicated.clear();
  }

  Future<void> cargarPagina() async {
    setState(ViewState.Busy);

    setPaginaCargada(false);

    await actualizarGrilla();

    setPaginaCargada(true);

    setState(ViewState.Idle);
  }
}
