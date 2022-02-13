import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:asteroid_test/src/pages/home/home_page.dart';
import 'package:asteroid_test/src/pages/incidente/incidente_view_model.dart';
import 'package:asteroid_test/src/widgets/custom_footer_bar.dart';
import 'package:asteroid_test/src/widgets/custom_loading.dart';
import 'package:asteroid_test/src/widgets/custom_toast.dart';
import 'package:asteroid_test/src/widgets/responsive_body.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:asteroid_test/src/models/incidente_model.dart';
import 'package:asteroid_test/src/apis/incidentes_api.dart';
import 'package:provider/provider.dart';

class IncidentePage extends StatefulWidget {
  final incidente;

  IncidentePage({this.incidente});

  @override
  _IncidentePageState createState() => _IncidentePageState();
}

class _IncidentePageState extends State<IncidentePage> {
  final formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  IncidenteModel incidente = new IncidenteModel();

  PickedFile foto;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (widget.incidente != null) {
      incidente = widget.incidente;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: _crearAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ResponsiveBody(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.height * 0.025),
                  _mostrarFoto(),
                  SizedBox(height: size.height * 0.025),
                  _crearTitulo(),
                  _crearDescripcion(),
                  widget.incidente != null
                      ? _crearFechaCreacion()
                      : SizedBox.shrink(),
                  widget.incidente != null
                      ? _crearFechaActualizacion()
                      : SizedBox.shrink(),
                  Spacer(),
                  CustomFooterBar(widget: _crearBoton()),
                  Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _crearAppBar() {
    return AppBar(
      centerTitle: true,
      title: widget.incidente != null
          ? Text('Modificar incidente')
          : Text('Crear incidente'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.photo_size_select_actual),
          onPressed: _seleccionarFoto,
        ),
        IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: _tomarFoto,
        ),
      ],
    );
  }

  Widget _crearTitulo() {
    return TextFormField(
      initialValue: incidente.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Título del incidente',
          labelStyle:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
      onSaved: (value) => incidente.titulo = value,
      validator: (value) {
        if (value.length <= 0) {
          return 'Ingrese el título del incidente';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDescripcion() {
    return TextFormField(
      initialValue: incidente.descripcion,
      decoration: InputDecoration(
          labelText: 'Descripción',
          labelStyle:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
      onSaved: (value) => incidente.descripcion = value,
    );
  }

  Widget _crearFechaCreacion() {
    var date = DateTime.fromMillisecondsSinceEpoch(incidente.createdAt);

    var formattedDate =
        DateFormat.yMMMd().add_Hms().format(date); // Apr 8, 2020

    return TextFormField(
      enabled: false,
      readOnly: true,
      initialValue: formattedDate.toString(),
      decoration: InputDecoration(
          labelText: 'Fecha de creación:',
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          )),
    );
  }

  Widget _crearFechaActualizacion() {
    if (incidente.updatedAt != null) {
      var date = DateTime.fromMillisecondsSinceEpoch(incidente.updatedAt);

      var formattedDate =
          DateFormat.yMMMd().add_Hms().format(date); // Apr 8, 2020

      return TextFormField(
        enabled: false,
        readOnly: true,
        initialValue: formattedDate.toString() ?? '-',
        decoration: InputDecoration(
            labelText: 'Ultima Actualización:',
            labelStyle: TextStyle(fontWeight: FontWeight.bold)),
      );
    }

    return TextFormField(
      enabled: false,
      readOnly: true,
      initialValue: '-',
      decoration: InputDecoration(
          labelText: 'Ultima Actualización:',
          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _crearBoton() {
    final incidenteVm = Provider.of<IncidenteViewModel>(context, listen: false);

    if (widget.incidente != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RaisedButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            color: Colors.red,
            textColor: Colors.white,
            label: Text('Borrar'),
            icon: Icon(Icons.delete),
            onPressed: () async {
              customLoadingService.showLoader(context, 'Borrando incidente...');

              await incidenteVm.borrarIncidente(incidente);

              await customLoadingService.hideLoader();

              Get.offAll(HomePage());

              toastService.showToast('Incidente borrado con exito!');
            },
          ),
          _crearBotonGuardar()
        ],
      );
    }
    return _crearBotonGuardar();
  }

  Widget _crearBotonGuardar() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: () async {
        await _submit(context);
      },
    );
  }

  _submit(BuildContext context) async {
    final incidenteVm = Provider.of<IncidenteViewModel>(context, listen: false);

    if (!formKey.currentState.validate()) return;

    customLoadingService.showLoader(context, 'Guardando incidente...');

    formKey.currentState.save();

    if (foto != null) {
      incidente.fotoUrl = await incidentesApi.subirImagen(File(foto.path));
    }

    if (incidente.id == null) {
      incidente.createdAt = DateTime.now().millisecondsSinceEpoch;

      final resp = await incidenteVm.crearIncidente(incidente);

      await customLoadingService.hideLoader();

      if (resp) {
        toastService.showToast('Incidente creado con éxito!');

        Get.offAll(HomePage());
      }

      if (!resp) {
        return toastService.showToast('El título ingresado ya existe.');
      }
    } else {
      incidente.updatedAt = DateTime.now().millisecondsSinceEpoch;

      final resp = await incidenteVm.modificarIncidente(incidente);

      await customLoadingService.hideLoader();

      if (resp) {
        toastService.showToast('Incidente modificado con éxito!');

        Get.offAll(HomePage());
      }

      if (!resp) {
        return toastService.showToast('El título ingresado ya existe.');
      }
    }
  }

  Widget _mostrarFoto() {
    final size = MediaQuery.of(context).size;

    //Si el incidente tiene una foto cargada en la nube => Mostramos un networkWidget
    if (incidente.fotoUrl != null) {
      return FadeInImage(
        image: NetworkImage(incidente.fotoUrl),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: size.width * 0.7,
        fit: BoxFit.contain,
      );
    }

    //Si el cliente carga la foto desde la web, mostramos un Image.Network
    if (kIsWeb) {
      foto != null
          ? Image.network(
              foto.path,
              height: size.width * 0.7,
              fit: BoxFit.cover,
            )
          : Image(image: AssetImage('assets/no-image.png'));
    }

    //Si carga la foto desde un device, mostramos un file image.
    return Image(
      image: foto?.path != null
          ? FileImage(File(foto.path))
          : AssetImage('assets/no-image.png'),
      height: size.width * 0.7,
      fit: BoxFit.cover,
    );
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker().getImage(source: origen);

    if (foto != null) {
      incidente.fotoUrl = null;
    }

    setState(() {});
  }
}
