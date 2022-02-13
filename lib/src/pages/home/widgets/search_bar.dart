import 'package:flutter/material.dart';
import 'package:asteroid_test/src/models/incidente_model.dart';
import 'package:asteroid_test/src/pages/home/home_view_model.dart';
import 'package:provider/provider.dart';

class SearchIncidents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Container(
        width: _size.width * 0.875,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: TextField(
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.go,
            style: TextStyle(color: Colors.black),
            onChanged: (value) => filtrar(value, context),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search,
                    size: _size.width * 0.075, color: Colors.deepPurple),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0),
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                labelText: 'Buscá por titulo',
                labelStyle: TextStyle(
                    color: Colors.grey[700], fontSize: _size.width * 0.045))));
  }

  void filtrar(value, BuildContext context) {
    final homeVm = Provider.of<HomeViewModel>(context, listen: false);

    List<IncidenteModel> dummySearchList = <IncidenteModel>[];

    dummySearchList.addAll(homeVm.listadoIncidentesDuplicated);

    if (value.isNotEmpty) {
      List<IncidenteModel> dummyListData = <IncidenteModel>[];
      dummySearchList.forEach((item) {
        if (item.titulo
            .toString()
            .toUpperCase()
            .contains(value.toUpperCase())) {
          dummyListData.add(item);
        }
      });
      homeVm.filtrarIncidentes(dummyListData);
    } else {
      homeVm.filtrarIncidentes(dummySearchList);
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
