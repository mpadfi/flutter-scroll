import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class PageProvider extends ChangeNotifier {
  //
  PageController scrollController = PageController();

  final List<String> _pages = ['home', 'about', 'pricing', 'contact', 'location'];
  int _currentIndex = 0;

  // creamos una nueva instancia del scrollcontroller para definir la página inicial
  createScrollController(String routeName) {
    scrollController = PageController(initialPage: getPageIndex(routeName));

    //? titulo de la pagina al iniciar el controller
    html.document.title = toBeginningOfSentenceCase(_pages[getPageIndex(routeName)])!;

    //? escuchamos los cambios en el pageview al hacer scroll
    scrollController.addListener(() {
      final index = (scrollController.page ?? 0).round();
      if (index != _currentIndex) {
        //? Crear historial del navegador para mostrar la ruta localhost...#/about etc
        html.window.history.pushState(null, 'none', '#/${_pages[index]}');
        _currentIndex = index;
        //? Titulo navegador
        html.document.title = toBeginningOfSentenceCase(_pages[index])!;
      }
    });
  }

  // obtenemos el indice de la página en función del nombre de la ruta, si no existe retornamos el index 0
  int getPageIndex(String routeName) {
    return (!_pages.contains(routeName)) ? 0 : _pages.indexOf(routeName);
  }

  goTo(int index) {
    // final routeName = _pages[index];
    scrollController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
