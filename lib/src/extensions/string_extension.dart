extension StringExtension on String {
  /// Verify if current string is a vowel (a,e,i,o,u)
  bool get isVowel => ['a', 'e', 'i', 'o', 'u'].contains(toLowerCase());

  /// Verify if current string is a consonant
  bool get isConsonant => !isVowel;

  /// Returns first letters from current string
  String first([int letters = 1]) => substring(0, letters);

  /// Returns last letters from current string
  String last([int letters = 1]) => substring(length - letters);

  /// Returns a character in the specified position
  String charAt(int position) => substring(position, position + 1);

  /// Returns current string without the first letters
  String removeFirst([int letters = 1]) => substring(letters);

  /// Returns current string without last letters
  String removeLast([int letters = 1]) => substring(0, length - letters);

  /// Returns current string and append a whitespace if 'when' condition is true
  String addSpace([bool when = true]) => '$this${when ? ' ' : ''}';

  /// Check if string has words separated by space
  bool hasWords() => split(' ').length > 1;

  /// Returns first word if any empty string in other case
  String firstWord() => hasWords() ? split(' ').first : '';

  /// Check if the first word is igual to string
  bool isFirstWord(String string) => firstWord() == string;

  /// Returns first word plus a string, no changes if there is no words
  String appendToFirstWord(String string) {
    if (hasWords()) {
      return replaceFirst(firstWord(), firstWord() + string);
    }
    return this;
  }

  /// Replace first word if any
  String replaceFirstWord(String to) {
    if (hasWords()) {
      replaceFirst(firstWord(), to);
    }
    return this;
  }
}
