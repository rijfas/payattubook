import 'package:flutter/material.dart';
import '../../../core/themes/app_theme.dart';
import '../../../core/utils/utils.dart';
import '../../../logic/authentication/cubit/authentication_cubit.dart';
import '../../../logic/manage_payattu/cubit/manage_payattu_cubit.dart';
import '../../../logic/transactions/cubit/transactions_cubit.dart';
import '../../router/app_router.dart';
import '../dashboard_screen/components/amount_popup.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/scan_qr/cubit/scan_qr_cubit.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  late final QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<ScanQrCubit, ScanQrState>(
      listener: (context, state) {
        if (state is ScanQrLoading) {
          Utils.showLoadingDialog(context);
        } else if (state is ScanQrError) {
          Utils.showSnackBar(context: context, message: state.message);
        } else if (state is ScanQrCompleted) {
          showDialog(
              context: context,
              builder: (_) => AmountPopup(
                  title:
                      'Enter Amount for the payattu of ${state.payattu.host}',
                  onSubmit: (value) {
                    final authState = context.read<AuthenticationCubit>().state
                        as AuthenticationCompleted;
                    context.read<ScanQrCubit>().addTransaction(
                          sender: Utils.supabase.auth.currentUser!.id,
                          senderName: authState.user.fullName,
                          payattu: state.payattu,
                          amount: double.parse(value),
                        );
                  }));
        } else if (state is TransactionAdded) {
          // context
          //     .read<ManagePayattuCubit>()
          //     .addPayattu(payattu: state.payattu, amount: state.amount);
          context.read<TransactionsCubit>().addTransaction(
                recipient: state.payattu.host,
                amount: state.amount,
                date: state.payattu.date,
              );
          Navigator.of(context).pushReplacementNamed(AppRouter.dashboardScreen);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scan QR'),
        ),
        body: QRView(
          key: _qrKey,
          onQRViewCreated: (controller) {
            _controller = controller;
            _controller.scannedDataStream.listen((event) {
              _controller.pauseCamera();
              context.read<ScanQrCubit>().scanQr(code: event.code!);
            });
          },
          overlay: QrScannerOverlayShape(
            borderColor: AppTheme.lightPrimaryColor,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: size.width * 0.8,
          ),
        ),
      ),
    );
  }
}
