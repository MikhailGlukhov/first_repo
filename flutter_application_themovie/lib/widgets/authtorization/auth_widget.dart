import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_application_themovie/widgets/authtorization/auth_model.dart';


import '../../Library/widget/inherited/provider.dart';
import '../../Theme/app_button_style.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Login to your account')),),
        body: ListView(
          children: [
            const _HeaderWidget()
          ],
        ),
    );
  }
}
class _HeaderWidget extends StatelessWidget {
 
  const _HeaderWidget({super.key});

  @override
  Widget build(BuildContext context)
   {
     const textStyle =  TextStyle(
     fontSize: 16,
            color: Colors.black
  );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25,),
          const _FormWidget(),
          const SizedBox(height: 25,),
          const Text('In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple. ',
          style: textStyle
          ),
           const SizedBox(height: 5,),
          TextButton(onPressed: (){},
          style: AppButtonStyle.linkButton,
           child: const Text('Registering')),
          const SizedBox(height: 25,),
          const Text('If you signed up but didn`t get your verification email',
          style: textStyle,),
           const SizedBox(height: 5,),
          TextButton(onPressed: (){},
          style: AppButtonStyle.linkButton,
           child: const Text('Verify email')),
        ],
      ),
    );
  }
}
class _FormWidget extends StatelessWidget {
  const _FormWidget({super.key});

 @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthModel>(context);
    const textStyle = TextStyle(
     fontSize: 16,
            color: Color(0xFF212529)
  );

  const texrFieldDecorator =  InputDecoration(border: OutlineInputBorder(),
  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  isCollapsed: true);
  
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const _ErrorMessageWidget(),
        const Text('Username',
        style: textStyle,),
        const SizedBox(height: 5,),
        TextField(
          controller: model?.loginTextController,
          decoration: texrFieldDecorator,
        ),
        const SizedBox(height: 20,),
        const Text('Password',
        style: textStyle,),
        const SizedBox(height: 5,),
        TextField(
          controller: model?.passwordTextController,
          decoration: texrFieldDecorator,
          obscureText: true,
        ),
        const SizedBox(height: 25,),
      Row(children: [
        const _AuthButtonWidget(),
         const SizedBox(width: 30,),
        TextButton(onPressed: (){},
        style: AppButtonStyle.linkButton,
         child: const Text('Reset Password')),
      ],)
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
    
  const _AuthButtonWidget({
    super.key,
   
  });

 

  @override
  Widget build(BuildContext context) {

     final model = NotifierProvider.watch<AuthModel>(context);
   const color =  Color(0xFF01B4E4);
   final onPressed =   model?.canStartAuth == true  ? () => model?.auth(context) : null;
   final child = model?.isAuthProgress == true
   ? const SizedBox(
    height: 15,
    width: 15,
    child:  CircularProgressIndicator(strokeWidth: 2,))
   : const Text('Login');
    return ElevatedButton(onPressed: onPressed,
       style: const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(color),
      foregroundColor: MaterialStatePropertyAll(Colors.white),
      textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      padding: MaterialStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 16, vertical: 8))
    ),
    
     child: child);
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final errorMessage = NotifierProvider.watch<AuthModel>(context)?.errorMessage;
    if(errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(errorMessage,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.red),),
    );
  }
}