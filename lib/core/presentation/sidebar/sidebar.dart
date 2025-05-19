import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigation/manager/navigation_cubit.dart';
import '../custom_logo.dart';
import 'sidebar_item.dart';

class Sidebar extends StatefulWidget {
  const Sidebar(
      {super.key,
      this.logo,
      this.active = 0,
      this.actions,
      this.width = 200,
      this.height = double.infinity,
      this.backgroundColor,
      this.isGlobal = true,
      this.menus});

  final double width;
  final double height;
  final int active;
  final Color? backgroundColor;
  final Widget? logo;
  final List<Widget>? actions;
  final List<SidebarItemModel>? menus;
  final bool isGlobal;

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  late NavigationCubit? _bloc;

  @override
  void initState() {
    if (widget.isGlobal) {
      _bloc = context.read<NavigationCubit>();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
        color:
            widget.backgroundColor ?? Theme.of(context).colorScheme.secondary,
      ),
      child: Column(children: [
        widget.logo ??
            CustomLogo(
              child: Image.asset('assets/logo.png'),
            ),
        const SizedBox(
          height: 32,
        ),
        Expanded(
            flex: 5,
            child: widget.isGlobal && _bloc != null
                ? BlocBuilder(
                    bloc: _bloc,
                    builder: (context, state) {
                      return ListView.builder(
                        itemCount: _bloc!.features.length,
                        itemBuilder: (context, index) => SidebarItem(
                            isActived: _bloc!.active == index,
                            icon: _bloc!.features[index].icon,
                            name: _bloc!.features[index].name,
                            onPressed: () {
                              _bloc!.navigate(context, index);
                            }),
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: (widget.menus ?? []).length,
                    itemBuilder: (context, index) => SidebarItem(
                        isActived: widget.active == index,
                        icon: (widget.menus ?? [])[index].icon,
                        name: (widget.menus ?? [])[index].name,
                        onPressed: () {}),
                  )),
        Expanded(
          flex: 1,
          child: widget.actions == null
              ? Container()
              : Column(
                  children: widget.actions!,
                ),
        )
      ]),
    );
  }
}

class SidebarItemModel {
  final IconData icon;
  final String name;
  final String route;

  SidebarItemModel(
      {required this.icon, required this.name, required this.route});
}
