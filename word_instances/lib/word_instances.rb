#!/usr/bin/env ruby

# frozen_string_literal: true

# accesses the previously created word_count GDBM database
# searches for a key in the database and prints the corresponding value
# for a given word input
module WordInstances
  def self.print_result
    require_relative 'word_instances/cli'
    word = CLI.run
    start = Time.now
    puts "Found #{number_of_occurences(word)} instances of '#{word}' in #{Time.now - start} seconds"
  end

  def self.number_of_occurences(word)
    require 'gdbm'
    gdbm = GDBM.new('db/word_count.db')
    gdbm[word].to_i
  rescue Errno::ENOENT
    puts 'Database cant be created'
    exit 1
  end

  private_class_method :number_of_occurences
end

WordInstances.print_result
