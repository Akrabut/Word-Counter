# frozen_string_literal: true

require_relative '../../lib/word_counter/file_handler'

RSpec.describe FileHandler do
  describe '::enumerable_text' do
    it 'does not blow up when the file is not found' do
      expect(FileHandler.enumerable_text('no_way_you_have_this_file.txt')).to not_raise(Errno::ENOENT)
    end

    it 'finds an existing text file, and returns an enumerable to be read line by line' do
      expect(FileHandler.enumerable_text('dummy_file.txt').is_a?(Enumerable)).to eq(true)
    end
  end
end
