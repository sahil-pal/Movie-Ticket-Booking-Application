import 'package:bigboxo_application/modules/payment/cubit/payment_cubit.dart';
import 'package:bigboxo_application/modules/payment/cubit/payment_state.dart';
import 'package:bigboxo_application/modules/payment/widgets/appbar.dart';
import 'package:bigboxo_application/modules/payment/widgets/payment_methods.dart';
import 'package:bigboxo_application/modules/payment/widgets/payment_successful.dart';
import 'package:bigboxo_application/modules/payment/widgets/ticket_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return BlocBuilder<PaymentCubit,PaymentState>(
      builder: (context,state){
        if(state is LoadedState){
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: PaymentAppBar(),
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TicketInfo(ticket: arguments['Ticket']),
                  PaymentMethods(ticket: arguments['Ticket'],)
                ],
              ),
            ),
          );
        }
        else if(state is SuccessfullState){
          return PaymentSuccessful();
        }
        else{
          return Container();
        }
      }
    );  
  }

  
}