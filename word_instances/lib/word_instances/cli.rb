# frozen_string_literal: true

# handles given input for the word instances program
# the input is either the first word given in ARGV, or the
# first word given manually if no arguments are entered
module CLI
  def self.run
    ARGV.first || manual_input
  end

  def self.manual_input
    puts 'No arguments given, enter key to display instances for'
    gets.chomp.split(' ').first
  end

  private_class_method :manual_input
end
