# frozen_string_literal: true

require_relative '../../lib/word_instances/cli'

RSpec.describe CLI do
  describe '::run' do
    it 'uses the first argument and disregards the rest when program is executed with arguments' do
      expect(CLI.run).to eq(ARGV.first) unless ARGV.empty?
    end
    it 'asks user to enter input manually when program is executed with no arguments' do
      expect(:manual_input)
      expect(CLI.run.nil?).to eq(false)
    end
  end
end
