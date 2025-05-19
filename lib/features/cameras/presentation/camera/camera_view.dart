import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import '../../../../core/presentation/appbar/appbar_logo.dart';
import '../../../../core/presentation/custom_button.dart';
import '../../../../core/presentation/custom_snackbar.dart';
import '../../../../core/presentation/custom_text.dart';
import 'bloc/camera_bloc.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key, required this.id});
  final String id;
  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  VlcPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    context.read<CameraBloc>().add(GetCamera(widget.id));
  }

  @override
  void dispose() {
    _controller?.stop();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CameraBloc, CameraState>(
      listener: (context, state) {
        if (state is ErrorRequested) {
          ScaffoldMessenger.of(context).showSnackBar(
              ErrorSnackbar(context: context, content: Text(state.message)));
        }
        if (state is SuccessRequested) {
          ScaffoldMessenger.of(context).showSnackBar(SuccessSnackbar(
              context: context,
              content: const Text('Sucesso no envio da requisição')));
        }
        if (state is CameraLoaded && _controller == null) {
          _controller = VlcPlayerController.network(
            state.data.rtsp,
            hwAcc: HwAcc.full,
            autoPlay: true,
            options: VlcPlayerOptions(),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarLogo(
            title: 'Câmera ${state is CameraLoaded ? state.data.name : ''}',
          ),
          body: Builder(builder: (context) {
            if (state is CameraLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CameraError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      'Falha: ${state.message}',
                      color: Colors.red,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomButton(
                        width: 200,
                        title: 'Recarregar',
                        onPressed: () {
                          context.read<CameraBloc>().add(GetCamera(widget.id));
                        })
                  ],
                ),
              );
            }

            return SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state is CameraLoaded)
                    Text(
                      state.data.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 64),
                    height: (MediaQuery.of(context).size.width - 64) * 9 / 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: _controller != null
                          ? Center(
                              child: VlcPlayer(
                                controller: _controller!,
                                aspectRatio: 16 / 9,
                                placeholder: const Center(
                                    child: CircularProgressIndicator()),
                              ),
                            )
                          : const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  if (state is CameraLoaded || state is CameraBusy)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: CustomButton(
                        title: 'Enviar HTTP',
                        onPressed: () {
                          if (state is CameraLoaded) {
                            context
                                .read<CameraBloc>()
                                .add(SendRequest(state.data));
                          }
                        },
                        isLoading: state is CameraBusy,
                        height: 56,
                      ),
                    )
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
