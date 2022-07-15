import 'package:bigboxo_application/config/constants/app_constants.dart';
import 'package:bigboxo_application/core/auth/bloc/auth_bloc.dart';
import 'package:bigboxo_application/core/auth/bloc/auth_event.dart';
import 'package:bigboxo_application/core/auth/widgets/custom_textfield.dart';
import 'package:bigboxo_application/utils/helpers/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/themes/mytheme.dart';
import '../bloc/auth_state.dart';
import '../widgets/social_loginbtn.dart';

class LoginScreen extends StatelessWidget {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotEmailController = TextEditingController();
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
        body: 
          BlocListener<AuthBloc,AuthState>(
            listener: (_,state){
              if(state is Authenticated){
                Navigator.restorablePopAndPushNamed(context, RouteConstants.HOME);
              }
              else if(state is AuthError){
                printOnToastBar(state.error, context, AppConstants.FAIL);
              }
            },
            child: BlocBuilder<AuthBloc,AuthState>(
              builder: (_,state){
                if(state is Loading){
                  return Center(
                    child: Container(
                      height: _size.height*0.15,
                      width: _size.width*0.15,
                      child: Image.asset('assets/splash/loading.jpeg')),
                  );
                }
                else if(state is UnAuthenticated){
                  return SafeArea(
                    child: Container(
                      padding: EdgeInsets.all(_size.width*0.03),
                      height: _size.height,
                      width: _size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/bigboxo-splash.svg"),
                          Text(
                            "Welcome Buddies",
                            style: MyTheme.currentTheme.textTheme.headline3
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Login to explore ',
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
                                    "Login to your account",
                                    style: MyTheme.currentTheme.textTheme.headline5
                                  ),
                                ),
                                SizedBox(height: _size.height*0.01),
                                CustomTextField(txtcontroller: emailController, hintText: 'Enter Username',iconData: Icons.email_outlined,),
                                SizedBox(height: _size.height*0.01),
                                CustomTextField(txtcontroller: passwordController, hintText: 'Enter Password',iconData: Icons.password_outlined,isObsecure: true,),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context,RouteConstants.FORGOT_PASSWORD);
                                    },
                                    child: Text("Forgot Password ?",style: MyTheme.currentTheme.textTheme.headline6),
                                  ),
                                ),
                                getLoginSubmitButton(authBloc),
                                getORDivider(),
                                SocialLoginButtons(
                                  onGoogleClick: () {
                                    authBloc.add(GoogleSignInRequested());
                                  },
                                ),
                                SizedBox(height: _size.height*0.025),
                              ],
                            ),
                          ),
                          getSignUpOption()
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ), 
        )
    );
  }

  getLoginSubmitButton(AuthBloc authBloc){
    return ElevatedButton(
      onPressed: () {
        
        if(emailController.text != '' && passwordController.text != ''){
          authBloc.add(SignInRequested(emailController.text.trim(), passwordController.text.trim()));
        }
        else{
          printOnToastBar('Error: Username or Password cannot be empty !', ctx, AppConstants.FAIL);
        }
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
                "LOGIN",
                  style: TextStyle(fontSize: 16),
              ),
            ),
          ),
      );
  }

  getORDivider(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical:10),
      child: Row(
        children: [
          getHorizontalDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text("Or",style: MyTheme.currentTheme.textTheme.headline6),
          ),
          getHorizontalDivider()
        ],
      ),
    );
  }

  getHorizontalDivider(){
    return Expanded(
      child: Divider(
      thickness: 0.5,
      color: Colors.black.withOpacity(0.3),
      ),
    );
  }

  getSignUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [
        Text("Don't have an account ? ",style: MyTheme.currentTheme.textTheme.headline5,),
        SizedBox(width: 1),
        TextButton(
          onPressed: (){
            Navigator.pushNamed(ctx, RouteConstants.SIGNUP);
          },
          child: Text('SignUp Now',style: MyTheme.currentTheme.textTheme.headline4,)
        )
      ],
    );
  }
}