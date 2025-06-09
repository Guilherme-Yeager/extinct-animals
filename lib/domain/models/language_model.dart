import 'package:circular_linked_list/circular_linked_list.dart';

final class LanguageModel with CircularLinkedListEntry<LanguageModel> {
  String language;

  LanguageModel(this.language);
}
