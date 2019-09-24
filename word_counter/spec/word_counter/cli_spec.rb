# frozen_string_literal: true

require_relative '../../lib/word_counter/cli'

RSpec.describe CLI do
  describe '::run' do
    it 'uses the first argument when program is executed with a file name argument' do
      expect(CLI.run).to eq(ARGV.first) if ARGV[0].end_with?('.txt')
    end

    it 'uses the first argument when the program is executed with a valid URL' do
      expect(CLI.run).to eq(ARGV.first) if ARGV[0].start_with?('http')
    end

    it 'uses the joined ARGV arguments as a string if the above conditions are not satisfied' do
      expect(CLI.run.is_a?(String)).to eq(true) if ARGV.empty?
    end

    it 'asks user to enter input manually when program is executed with no arguments' do
      expect(:manual_input)
      expect(CLI.run.nil?).to eq(false)
    end
  end
end
