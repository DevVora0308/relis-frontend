import 'package:relis/globals.dart';

class PageArguments{
  final pageType page;
  dynamic /*Map<String, dynamic>*/ currentCategory;
  dynamic personName;
  dynamic type;
  PageArguments(this.page, {this.currentCategory, this.personName, this.type});
}