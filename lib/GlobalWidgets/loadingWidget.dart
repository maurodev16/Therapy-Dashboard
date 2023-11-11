import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:therapy_dashboard/Utils/Colors.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SpinKitFadingCircle(
            color: vermelho, // Cor do indicador de loading
            size: 40.0, // Tamanho do indicador de loading
          ),
        ),
      ),
    );
  }
}
