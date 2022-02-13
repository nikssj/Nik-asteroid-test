import 'package:flutter/material.dart';
import 'package:asteroid_test/src/helpers/global_key.dart';

final customLoadingService = CustomLoading();

bool isLoadingActive = false;

//Spinner de carga con gif.

class CustomLoading {
  BuildContext dialogContext;

  loadingWidget(BuildContext context, String msg) {
    final _size = MediaQuery.of(context).size;

    return WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(60.0))),
            child: SizedBox(
                height: _size.height * 0.13,
                width: double.infinity,
                child: Center(
                  child: ListTile(
                      leading: SizedBox(
                          child: Image.asset(
                        'assets/double_ring_loading_io.gif',
                      )),
                      title: Text(msg,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _size.width * 0.045))),
                ))));
  }

  void showLoader(BuildContext context, String msg) {
    isLoadingActive = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((BuildContext context) {
          myGlobals.setSnackBarContext = context;
          return loadingWidget(myGlobals.snackBarContext, msg);
        }));
  }

  hideLoader() async {
    if (isLoadingActive) {
      try {
        isLoadingActive = false;

        await Future.delayed(Duration(seconds: 1));

        Navigator.of(myGlobals.snackBarContext).pop();
      } catch (e) {
        print(e);
      }
    }
  }
}
