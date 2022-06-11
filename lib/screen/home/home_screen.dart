import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: const _HomeMainView(),
    );
  }
}

class _HomeMainView extends StatefulWidget {
  const _HomeMainView({Key? key}) : super(key: key);

  @override
  State<_HomeMainView> createState() => __HomeMainViewState();
}

class __HomeMainViewState extends State<_HomeMainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hi mom'),
      ),
    );
  }
}
