import 'package:circular_linked_list/circular_linked_list.dart';

final class LanguageModel with CircularLinkedListEntry<LanguageModel> {
  final String countyrCode;
  final String languageCode;

  LanguageModel({required this.countyrCode, required this.languageCode});
}
