# frozen_string_literal: true

require_relative '../../lib/word_counter/word_parser'

RSpec.describe WordParser do
  class DummyClass
    include WordParser
  end

  subject(:word_parser) { DummyClass.new }

  describe '#start_of_word?' do
    it 'returns true when the previous character was a space, an enter or did not exist, and the current one is alphabetical' do
      expect(word_parser.send(:start_of_word?, 'h', ' ', 3)).to eq(true)
      expect(word_parser.send(:start_of_word?, 'h', "\n", 2)).to eq(true)
      expect(word_parser.send(:start_of_word?, 'h', nil, 1)).to eq(true)
    end

    it 'return false otherwise' do
      expect(word_parser.send(:start_of_word?, 'a', 'b', 2)).to eq(false)
    end
  end

  describe '#end_of_word?' do
    it 'returns true if the current character is alphabetical, and the next one is not' do
      expect(word_parser.send(:end_of_word?, 'c', '/')).to eq(true)
      expect(word_parser.send(:end_of_word?, 'c', ' ')).to eq(true)
    end
    it 'returns false otherwise' do
      expect(word_parser.send(:end_of_word?, 'c', 'd')).to eq(false)
    end
  end

  describe '#invalid_word?' do
    it 'returns true if a word is empty or very long' do
      expect(word_parser.send(:invalid_word?, 'a' * 100)).to eq(true)
      expect(word_parser.send(:invalid_word?, '')).to eq(true)
    end

    it 'returns false otherwise' do
      expect(word_parser.send(:invalid_word?, 'hello')).to eq(false)
    end
  end

  describe '#words_from_line' do
    it 'takes a line and a hash, and mutates the hash so that values are incremented by the amount of key appearences in the line' do
      hash = Hash.new(0)
      word_parser.words_from_line("DONT YOU WORRY WORDPARSER WE'VE GOT YOU COVERED", hash)
      expect(hash.key?("we've")).to eq(false)
      expect(hash.key?('ve')).to eq(false)
      expect(hash).to eq('dont' => 1, 'you' => 2, 'worry' => 1, 'wordparser' => 1, 'we' => 1, 'got' => 1, 'covered' => 1)
    end
  end
end
