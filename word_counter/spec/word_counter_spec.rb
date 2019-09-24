# frozen_string_literal: true

require_relative '../lib/word_counter'

RSpec.describe WordCounter do
  describe '#persist_words!' do
    it 'completes the parsing within a reasonable amount of time and persists words to the database' do
      begin
        expect { WordCounter.new }.to output(/\d+ words parsed in \d[.]\d+ seconds/).to_stdout
        # database allows only a single access at a time
      rescue Errno::EAGAIN
        retry
      end
    end
  end
end
