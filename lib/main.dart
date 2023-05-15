import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController etanolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  String _resultado = "Informe os valores";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _calculaCombustivelIdeal() {
    double vEtanol = double.parse(etanolController.text.replaceAll(",", "."));
    double vGasolina =
        double.parse(gasolinaController.text.replaceAll(",", "."));
    double proporcao = vEtanol / vGasolina;

    setState(() {
      _resultado =
          (proporcao < 0.7) ? "Abasteça com Etanol" : "Abasteça com Gasolina";
    });

    // ^ é o mesmo que...:
    // if (proporcao < 0.7) {
    //   _resultado = "Abasteça com Etanol";
    // } else {
    //   _resultado = "Abasteça com Gasolina";
    // }
  }

  void _reset() {
    etanolController.text = "";
    gasolinaController.text = "";
    setState(() {
      _resultado = "Informe os valores";
      _formKey = GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Etanol ou Gasolina?"),
          backgroundColor: Colors.lightBlue[900],
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  _reset();
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.local_gas_station,
                        size: 120,
                        color: Colors.lightBlue[900],
                      ),
                      TextFormField(
                        controller: etanolController,
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                            labelText: "Valor do Etanol",
                            labelStyle:
                                TextStyle(color: Colors.lightBlue[900])),
                        style: TextStyle(
                            fontSize: 26, color: Colors.lightBlue[900]),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Informe o valor do etanol!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                          controller: gasolinaController,
                          textAlign: TextAlign.center,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                              labelText: "Valor da Gasolina",
                              labelStyle:
                                  TextStyle(color: Colors.lightBlue[900])),
                          style: TextStyle(
                              fontSize: 26, color: Colors.lightBlue[900]),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Informe o valor da gasolina";
                            } else {
                              return null;
                            }
                          }),
                      const SizedBox(height: 20),
                      Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 26),
                          child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightBlue[900]),
                                child: const Text(
                                  "Verificar",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _calculaCombustivelIdeal();
                                  }
                                },
                              ))),
                      Text(
                        _resultado,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.lightBlue[900], fontSize: 26),
                      )
                    ]))));
  }
}
