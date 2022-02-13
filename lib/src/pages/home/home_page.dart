import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:asteroid_test/src/models/incidente_model.dart';

import 'package:asteroid_test/src/pages/home/home_view_model.dart';
import 'package:asteroid_test/src/pages/home/widgets/search_bar.dart';
import 'package:asteroid_test/src/pages/incidente/incidente_page.dart';
import 'package:asteroid_test/src/pages/login/login_page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeViewModel>(context, listen: false).cargarPagina();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _crearAppBar(),
      body: _crearListado(),
      floatingActionButton: _crearBoton(),
    );
  }

  Widget _crearAppBar() {
    return AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.offAll(LoginPage());
          },
          child: Icon(Icons.logout, color: Colors.red),
        ),
        centerTitle: true,
        title: Text('Listado de incidentes'));
  }

  Widget _crearListado() {
    final homeVm = Provider.of<HomeViewModel>(context, listen: true);

    final size = MediaQuery.of(context).size;

    if (!homeVm.paginaCargada) {
      return Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: size.height * 0.025),
            SearchIncidents(),
            SizedBox(height: size.height * 0.025),
            Divider(
              color: Colors.black,
              height: 0,
              indent: size.width * 0.07,
              endIndent: size.width * 0.07,
            ),
            SizedBox(height: size.height * 0.025),
            Expanded(
              child: BounceInUp(
                child: SizedBox(
                  width: size.width * 0.9,
                  child: ListView.builder(
                    itemCount: homeVm.listadoIncidentes.length,
                    itemBuilder: (context, i) =>
                        _crearItem(homeVm.listadoIncidentes[i]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearItem(IncidenteModel incidente) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text('${incidente.titulo}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.deepPurple)),
              subtitle: Text(
                incidente.descripcion ?? 'Descripcion',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () => Get.to(IncidentePage(incidente: incidente)),
              trailing: Icon(Icons.arrow_forward_ios_outlined)),
        ],
      ),
    );
  }

  Widget _crearBoton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () => Get.to(IncidentePage()));
  }
}
