import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/avioneta_model.dart';
import '../../data/repository/avioneta_repository.dart';
import 'avioneta_state.dart';

class AvionetaCubit extends Cubit<AvionetaState> {
  final AvionetaRepository repository;

  AvionetaCubit(this.repository) : super(AvionetaInitial());

  Future<void> fetchAvionetas() async {
    try {
      emit(AvionetaLoading());
      final avionetas = await repository.getAllAvionetas();
      print('Fetched avionetas: $avionetas');
      emit(AvionetaLoaded(avionetas));
    } catch (e) {
      print('Error fetching avionetas: $e');
      emit(AvionetaError('Failed to fetch avionetas: $e'));
    }
  }

  Future<void> createAvioneta(Avioneta avioneta) async {
    try {
      await repository.createAvioneta(avioneta);
      fetchAvionetas();
    } catch (e) {
      print('Error creating avioneta: $e');
      emit(AvionetaError('Failed to create avioneta: $e'));
    }
  }

  Future<void> updateAvioneta(Avioneta avioneta) async {
    try {
      await repository.updateAvioneta(avioneta);
      fetchAvionetas();
    } catch (e) {
      print('Error updating avioneta: $e');
      emit(AvionetaError('Failed to update avioneta: $e'));
    }
  }

  Future<void> deleteAvioneta(int id) async {
    try {
      await repository.deleteAvioneta(id);
      fetchAvionetas();
    } catch (e) {
      print('Error deleting avioneta: $e');
      emit(AvionetaError('Failed to delete avioneta: $e'));
    }
  }
}
