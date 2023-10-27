class Util {
  static bool isVowel(String value) =>
      ['a', 'e', 'i', 'o', 'u'].contains(value.toLowerCase());

  static bool isConsonant(String value) => !isVowel(value);

  static String first(String string, [int letters = 1]) =>
      string.substring(0, letters);

  static String last(String string, [int letters = 1]) =>
      string.substring(string.length - letters);

  static String removeFirst(String string, [int letters = 1]) =>
      string.substring(letters);

  static String removeLast(String string, [int letters = 1]) =>
      string.substring(0, string.length - letters);
}
