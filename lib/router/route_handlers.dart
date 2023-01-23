import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:vertical_landing/providers/page_provider.dart';
import 'package:vertical_landing/ui/pages/home_page.dart';

final homeHandler = Handler(handlerFunc: (context, params) {
  // filtramos la ruta para que solo se cree la ruta /home y no /
  final page = params['page']!.first;
  if (page != '/') {
    //
    final pageProvider = Provider.of<PageProvider>(context!, listen: false);
    pageProvider.createScrollController(page);
    return HomePage();
  }
  return null;
});
