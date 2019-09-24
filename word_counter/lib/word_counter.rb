#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative 'word_counter/word_parser.rb'

# uses word parser module parse a text into a hash
# that maps words => count in text using the word parser module
# after parsing the text into a hash, sums each value with the value
# in the database for each key, and persists the data to the GDBM database
class WordCounter
  include WordParser

  def initialize
    require_relative 'word_counter/cli'
    @source = CLI.run
    persist_words!
  end

  private

  # sums the current value for each with the new count
  # and persists the new values to the database
  def persist_words!
    start = Time.now
    # gdbm is a fast, simple key-value DB
    require 'gdbm'
    gdbm = GDBM.new('db/word_count.db')
    count = 0
    read_text_into_hash.each do |k, v|
      # gdbm stores values as strings, so values have to be converted to
      # integers, added together and then converted to strings again
      # to be stored
      current_value = gdbm[k].to_i
      gdbm[k] = (v.to_i + current_value).to_s
      count += 1
    end
    print_status(start, count)
  end

  def read_text_into_hash
    @source.each_with_object(Hash.new(0)) do |line, word_hash|
      words_from_line(line, word_hash)
    end
  end

  def print_status(start, count)
    puts "#{count} words parsed in #{Time.now - start} seconds"
  end
end

WordCounter.new
