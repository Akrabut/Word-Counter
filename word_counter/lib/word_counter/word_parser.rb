# frozen_string_literal: true

# a collection of methods used to parse lines of text into separate, valid words
module WordParser
  def words_from_line(line, word_hash)
    word = ''
    non_alpha_flag = false
    # micro optimizations for faster parsing of very large data
    # iterating a single character at a time rather than splitting
    line.each_char.with_index do |c, i|
      # appends letter to the current word if its a letter, or skip
      # the iteration if its not a letter
      non_alpha_flag = true if start_of_word?(line[i], line[i - 1], i)
      # the flag is set to false once the first non alpha char is encountered
      # so that it skips all iterations until the next start of a legitimate word
      next unless non_alpha_flag

      non_alpha_flag = false unless letter?(c)
      word += c.downcase if letter?(c)
      if end_of_word?(line[i], line[i + 1])
        word_hash[word] += 1 unless invalid_word?(word)
        word = ''
      end
    end
  end

  private

  def start_of_word?(current_char, previous_char, idx)
    # words are delimited by an arbitrary number of whitespaces
    # this however may not be the case when its the first character of a line
    letter?(current_char) && ([' ', "\n", nil].include?(previous_char) || idx.zero?)
  end

  def end_of_word?(current_char, next_char)
    letter?(current_char) && !letter?(next_char)
  end

  def letter?(char)
    return unless char

    # time bound by the number of letters in the english alphabet,
    # so that's only 26 ifs without nested loops
    char.match?(/[a-zA-Z]/)
  end

  def invalid_word?(word)
    # the longest word in English is around 50 characters long
    # so a million character long gibberish words should probably
    # be avoided
    word.empty? || word.length >= 50
  end
end
