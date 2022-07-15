import 'package:bigboxo_application/core/auth/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/themes/mytheme.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/custom_textfield.dart';

class SignUpScreen extends StatelessWidget {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cnfPassController = TextEditingController();
  late BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    final Size _size = MediaQuery.of(context).size;
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: MyTheme.splash,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(_size.width*0.03),
            height: _size.height,
            width: _size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: _size.height*0.025,),
                SvgPicture.asset("assets/icons/bigboxo-splash.svg"),
                Text(
                  "Welcome Buddies",
                  style: MyTheme.currentTheme.textTheme.headline3
                ),
                RichText(
                  text: TextSpan(
                    text: 'SignUp to explore ',
                    children:[
                      TextSpan(text: 'Box Office of Deals !', style: MyTheme.currentTheme.textTheme.headline6),
                    ],
                  ),
                ),
                SizedBox(
                  height: _size.height*0.02,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: EdgeInsets.all(_size.width*0.04),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: _size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          "Create your account",
                          style: MyTheme.currentTheme.textTheme.headline5
                        ),
                      ),
                      SizedBox(height: _size.height*0.01),
                      CustomTextField(txtcontroller: nameController, hintText: 'Enter Name',iconData: Icons.perm_identity_outlined,),
                      SizedBox(height: _size.height*0.01),
                      CustomTextField(txtcontroller: emailController, hintText: 'Enter Email',iconData: Icons.email_outlined,),
                      SizedBox(height: _size.height*0.01),
                      CustomTextField(txtcontroller: passwordController, hintText: 'Enter Password',isObsecure: true,iconData: Icons.password_outlined,),
                      SizedBox(height: _size.height*0.01),
                      CustomTextField(txtcontroller: cnfPassController, hintText: 'Confirm Password',isObsecure: true,iconData: Icons.password_rounded,),
                      SizedBox(height: _size.height*0.01),
                      getSignUpButton(authBloc),
                      SizedBox(height: _size.height*0.01),
                    ],
                  ),
                ),
                getLoginOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  getSignUpButton(AuthBloc authBloc){
    return ElevatedButton(
      onPressed: () {
        authBloc.add(SignUpRequested(emailController.text.trim(), passwordController.text.trim()));
      },
      style: ElevatedButton.styleFrom(
        primary: MyTheme.splash,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: const Center(
        child: Padding(
            padding: EdgeInsets.all(12),
              child: Text(
                "SIGNUP",
                  style: TextStyle(fontSize: 16),
              ),
            ),
          ),
      );
  }

  getLoginOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [
        Text("Already have an account ? ",style: MyTheme.currentTheme.textTheme.headline5,),
        const SizedBox(width: 1),
        TextButton(
          onPressed: (){
            Navigator.pop(ctx);
          },
          child: Text('Login Here',style: MyTheme.currentTheme.textTheme.headline4,)
        )
      ],
    );
  }

}