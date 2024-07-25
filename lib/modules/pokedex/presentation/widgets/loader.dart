import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/utils/app_colors.dart';

class Loader<B extends StateStreamable<S>, S> extends StatelessWidget {
  final BlocWidgetSelector<S, bool> selector;

  const Loader({super.key, required this.selector});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, S, bool>(
      selector: selector,
      builder: (context, loading) => Visibility(
          visible: loading,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.20),
              const CircularProgressIndicator(
                color: AppColors.primaryRed,
              ),
            ],
          )),
    );
  }
}
