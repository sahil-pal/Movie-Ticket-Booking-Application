import 'package:bigboxo_application/modules/payment/cubit/payment_state.dart';
import 'package:bigboxo_application/modules/payment/repo/ticket_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/constants/app_constants.dart';
import '../../booking/models/ticket.dart';

class PaymentCubit extends Cubit<PaymentState>{
  
  late TicketOperations ticketOperations;

  PaymentCubit({required this.ticketOperations}) : super(LoadedState());
  
  initiatePayment(Ticket ticket){
    ticketOperations.updateBookedSeats(ticket);
    emit(SuccessfullState());
  }

  moveToHome(BuildContext context){
    Navigator.of(context).pushNamedAndRemoveUntil(RouteConstants.HOME, (Route<dynamic> route) => false);
    Future.delayed(const Duration(seconds: 5),(){
      emit(LoadedState());
    });
  }
}