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

  /// Returns current string without last letters
  String removeLast([int letters = 1]) => substring(0, length - letters);

  /// Returns current string and append a whitespace if 'when' condition is true
  String addSpace([bool when = true]) => '$this${when ? ' ' : ''}';
}
