import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/extensions/context_extension.dart';

import '../../../../core/models/list_item_model.dart';
import '../../../../core/presentation/appbar/appbar_logo.dart';
import '../../../../core/presentation/lists/list_1_widget.dart';
import '../../../../core/presentation/table_widget.dart';
import '../../../../core/presentation/custom_button.dart';
import '../../../../core/presentation/custom_text.dart';
import 'bloc/cameras_bloc.dart';

class CamerasView extends StatefulWidget {
  const CamerasView({super.key});

  @override
  State<CamerasView> createState() => _CamerasViewState();
}

class _CamerasViewState extends State<CamerasView> {
  @override
  void initState() {
    super.initState();
    context.read<CamerasBloc>().add(GetCameras());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CamerasBloc, CamerasState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const AppBarLogo(
            title: 'Câmeras',
          ),
          body: Builder(builder: (context) {
            if (state is CamerasLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CamerasError) {
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
                          context.read<CamerasBloc>().add(GetCameras());
                        })
                  ],
                ),
              );
            }
            if (state is CamerasLoaded) {
              return Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: context.isDesktop
                            ? SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: TableWidget(
                                      data: state.data,
                                      columns: [
                                        TableOptionModel(name: '#'),
                                        TableOptionModel(name: "Nome")
                                      ],
                                      parser: (element) => [
                                        TableOptionModel(
                                            name: element.id ?? ''),
                                        TableOptionModel(name: element.name)
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : List1Widget(
                                onTap: (index) {
                                  context.pushNamed('get-camera',
                                      pathParameters: {
                                        'id': state.data[index].id!
                                      });
                                },
                                background: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                items: state.data
                                    .map((element) => ListItemModel(
                                          title: element.name,
                                        ))
                                    .toList(),
                              )),
                  ],
                ),
              );
            }
            return Container();
          }),
        );
      },
    );
  }
}
