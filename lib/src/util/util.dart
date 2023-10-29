class Util {
  static bool isVowel(String value) =>
      ['a', 'e', 'i', 'o', 'u'].contains(value.toLowerCase());

  static bool isConsonant(String value) => !isVowel(value);

  static String first(String string, [int letters = 1]) =>
      string.substring(0, letters);

  static String last(String string, [int letters = 1]) =>
      string.substring(string.length - letters);

  static String lessFirst(String string, [int letters = 1]) =>
      string.substring(letters);

  static String lessLast(String string, [int letters = 1]) =>
      string.substring(0, string.length - letters);

  static String replaceFirst(String string, String replacement) =>
      replacement + string.substring(replacement.length);

  static String replaceLast(String string, String replacement) =>
      string.substring(0, string.length - replacement.length) + replacement;

  static bool startsWith(String string, String search) =>
      string.substring(0, search.length) == search;

  static bool endsWith(String string, String search) =>
      string.substring(string.length - search.length) == search;
}
