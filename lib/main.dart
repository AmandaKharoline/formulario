import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário Cadastro de Reserva',
      home: Scaffold(
        appBar: AppBar(
           title: Text(
    'Formulário Cadastro de Reserva',
    style: TextStyle(
      color: Colors.white, // Define a cor do texto como branco
      fontWeight: FontWeight.bold, // Define o peso da fonte como negrito
    ),
  ),
  backgroundColor: Colors.green[800], // Supondo que você ainda queira a AppBar verde escuro
),
        body: DataEntryForm(),
      ),
    );
  }
}

class DataEntryForm extends StatefulWidget {
  @override
  _DataEntryFormState createState() => _DataEntryFormState();
}

class _DataEntryFormState extends State<DataEntryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _floatController = TextEditingController();
  final _stringController = TextEditingController();
  final _dataEntradaController = TextEditingController();
  final _dataSaidaController = TextEditingController();
  int _numeroSelecionado = 1;

  @override
  void dispose() {
    _nomeController.dispose();
    _floatController.dispose();
    _stringController.dispose();
    _dataEntradaController.dispose();
    _dataSaidaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome Completo'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome do cliente';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _floatController,
              decoration: InputDecoration(labelText: 'Valor (float)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o valor da hospedagem';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _stringController,
              decoration: InputDecoration(labelText: 'Forma de Pagamento'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Forma de pagamento';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _dataEntradaController,
              decoration: InputDecoration(labelText: 'Data de Entrada'),
              onTap: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                  setState(() {
                    _dataEntradaController.text = formattedDate;
                  });
                }
              },
            ),
            DropdownButtonFormField(
              value: _numeroSelecionado,
              items: List.generate(12, (index) => index + 1)
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (int? newValue) {
                if (newValue != null) {
                  setState(() {
                    _numeroSelecionado = newValue;
                  });
                }
              },
              decoration: InputDecoration(labelText: 'Quarto (1-12)'),
            ),
            TextFormField(
              controller: _dataSaidaController,
              decoration: InputDecoration(labelText: 'Data de Saída'),
              onTap: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                  setState(() {
                    _dataSaidaController.text = formattedDate;
                  });
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                  }
                },
                child: Text(
                'Enviar',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Texto em negrito
                  fontSize: 20, // Tamanho da fonte
                ),
                ),
                
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
