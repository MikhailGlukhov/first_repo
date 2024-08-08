
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sport_tracker/auth/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';
part 'sign_in_bloc.freezed.dart';

class SignInBloc extends Bloc<SigInEvent, SignInState> {
  final AuthRepository authRepository;
  
  SignInBloc(this.authRepository) : super(const SignInState.initial()) {
    
    on<SignInLoginEvent>((event, emit) async{
      emit(const SignInState.inProcess());
      try { 
        await authRepository.signIn(email: event.email, password: event.password);
        emit(const SignInState.sucess());
       
      } catch (e) {
        // SnackBar(content: Text(e.toString()),);
        log(e.toString());
        emit(SignInState.error(e.toString()));
      }
    });
    on<SingInLogOutEvent>((event, emit) async{
      await authRepository.signOut();
    });
  }
}