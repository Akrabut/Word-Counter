# frozen_string_literal: true

require_relative '../../lib/word_counter/string_handler'

RSpec.describe StringHandler do
  describe '::enumerable_text' do
    it 'takes a string and returns an each_line enumerable' do
      expect(StringHandler.enumerable_text("hopefully this test passes\neven where there are\nmultiple lines").is_a?(Enumerable)).to eq(true)
    end
  end
end
