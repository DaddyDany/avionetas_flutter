import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/avioneta_repository.dart';
import 'presentation/cubit/avioneta_cubit.dart';
import 'screens/home_screen.dart';

void main() {
  final avionetaRepository = AvionetaRepository();

  runApp(MyApp(avionetaRepository: avionetaRepository));
}

class MyApp extends StatelessWidget {
  final AvionetaRepository avionetaRepository;

  MyApp({required this.avionetaRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AvionetaCubit>(
          create: (context) => AvionetaCubit(avionetaRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Avionetas App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
