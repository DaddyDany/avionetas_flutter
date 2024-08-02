import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/cubit/avioneta_cubit.dart';
import '../presentation/cubit/avioneta_state.dart';
import '../data/models/avioneta_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final avionetaCubit = BlocProvider.of<AvionetaCubit>(context);

    // Llamar a fetchAvionetas al iniciar
    avionetaCubit.fetchAvionetas();

    return Scaffold(
      appBar: AppBar(
        title: Text('Avionetas'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showCreateModal(context),
          ),
        ],
      ),
      body: BlocBuilder<AvionetaCubit, AvionetaState>(
        builder: (context, state) {
          if (state is AvionetaLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AvionetaLoaded) {
            return ListView(
              children: state.avionetas.map((avioneta) {
                return Card(
                  child: ListTile(
                    title: Text(avioneta.modelo),
                    subtitle: Text('Tipo: ${avioneta.tipo}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _showEditModal(context, avioneta),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => avionetaCubit.deleteAvioneta(avioneta.id),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          } else if (state is AvionetaError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('No data'));
        },
      ),
    );
  }

  void _showCreateModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CreateEditAvionetaModal(
          onSave: (avioneta) => BlocProvider.of<AvionetaCubit>(context).createAvioneta(avioneta),
        );
      },
    );
  }

  void _showEditModal(BuildContext context, Avioneta avioneta) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CreateEditAvionetaModal(
          avioneta: avioneta,
          onSave: (updatedAvioneta) => BlocProvider.of<AvionetaCubit>(context).updateAvioneta(updatedAvioneta),
        );
      },
    );
  }
}

class CreateEditAvionetaModal extends StatefulWidget {
  final Avioneta? avioneta;
  final Function(Avioneta) onSave;

  CreateEditAvionetaModal({this.avioneta, required this.onSave});

  @override
  _CreateEditAvionetaModalState createState() => _CreateEditAvionetaModalState();
}

class _CreateEditAvionetaModalState extends State<CreateEditAvionetaModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _modeloController;
  late TextEditingController _tipoController;
  late TextEditingController _profundidadController;
  late TextEditingController _velocidadController;

  @override
  void initState() {
    super.initState();
    _modeloController = TextEditingController(text: widget.avioneta?.modelo);
    _tipoController = TextEditingController(text: widget.avioneta?.tipo);
    _profundidadController = TextEditingController(text: widget.avioneta?.profundidadMaxima);
    _velocidadController = TextEditingController(text: widget.avioneta?.velocidad);
  }

  @override
  void dispose() {
    _modeloController.dispose();
    _tipoController.dispose();
    _profundidadController.dispose();
    _velocidadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _modeloController,
              decoration: InputDecoration(labelText: 'Modelo'),
              validator: (value) => value!.isEmpty ? 'Ingrese un modelo' : null,
            ),
            TextFormField(
              controller: _tipoController,
              decoration: InputDecoration(labelText: 'Tipo'),
              validator: (value) => value!.isEmpty ? 'Ingrese un tipo' : null,
            ),
            TextFormField(
              controller: _profundidadController,
              decoration: InputDecoration(labelText: 'Profundidad Máxima'),
              validator: (value) => value!.isEmpty ? 'Ingrese una profundidad máxima' : null,
            ),
            TextFormField(
              controller: _velocidadController,
              decoration: InputDecoration(labelText: 'Velocidad'),
              validator: (value) => value!.isEmpty ? 'Ingrese una velocidad' : null,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final avioneta = Avioneta(
                    id: widget.avioneta?.id ?? 0,
                    modelo: _modeloController.text,
                    tipo: _tipoController.text,
                    profundidadMaxima: _profundidadController.text,
                    velocidad: _velocidadController.text,
                  );
                  widget.onSave(avioneta);
                  Navigator.of(context).pop();
                }
              },
              child: Text(widget.avioneta == null ? 'Crear' : 'Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
