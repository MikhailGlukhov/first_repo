import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sport_tracker/auth/auth_repository.dart';
import 'package:sport_tracker/auth/auth_widget.dart';
import 'package:sport_tracker/email_verification/bloc/verification_bloc.dart';
import 'package:sport_tracker/sport_tracker.dart';

class EmailVerificationWidget extends StatelessWidget {
  const EmailVerificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocListener<VerificationBloc, VerificationState>(
          listener: (context, state) {
            state.when(
                initial: () => const CircularProgressIndicator(),
                inProcess: () => const CircularProgressIndicator(),
                sentEmail: () => const SportTracker());
          },
          child: ElevatedButton(
              onPressed: () {
                context
                    .read<VerificationBloc>()
                    .add(const VerificationEvent.sendEmailVerification());
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthWidget()));
              },
              child: const Row(
                children: [Icon(Icons.email), Text('Verificate your email')],
              )),
        ),
      ),
    ));
  }
}