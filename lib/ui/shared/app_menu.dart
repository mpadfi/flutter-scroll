import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vertical_landing/providers/page_provider.dart';
import 'package:vertical_landing/ui/shared/custom_menu_item.dart';

class AppMenu extends StatefulWidget {
  const AppMenu({super.key});

  @override
  State<AppMenu> createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> with SingleTickerProviderStateMixin {
  //
  bool isOpen = false;
  late AnimationController controller; // late, se inicializa en el momento de usarlo

  @override
  void initState() {
    super.initState();
    // inicializamos el controlador
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    //
    final pageProvider = Provider.of<PageProvider>(context, listen: false);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (isOpen) {
            controller.reverse();
          } else {
            controller.forward();
          }
          setState(() {
            isOpen = !isOpen;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: 150,
          height: isOpen ? 308 : 50,
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MenuTitle(isOpen: isOpen, controller: controller),
              if (isOpen) ...[
                CustomMenuItem(text: 'Home', delay: 0, onPressed: () => pageProvider.goTo(0)),
                CustomMenuItem(text: 'About', delay: 100, onPressed: () => pageProvider.goTo(1)),
                CustomMenuItem(text: 'Pricing', delay: 200, onPressed: () => pageProvider.goTo(2)),
                CustomMenuItem(text: 'Contact', delay: 300, onPressed: () => pageProvider.goTo(3)),
                CustomMenuItem(text: 'Location', delay: 400, onPressed: () => pageProvider.goTo(4)),
                const SizedBox(
                  height: 8,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuTitle extends StatelessWidget {
  final bool isOpen;
  final AnimationController controller;

  const _MenuTitle({
    Key? key,
    required this.isOpen,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: isOpen ? 40 : 0,
          ),
          Text('Menú', style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
          const Spacer(),
          AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: controller,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
