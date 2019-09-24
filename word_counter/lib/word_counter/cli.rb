# frozen_string_literal: true

# handles the program's input
# takes a string as input and checks whether its a valid url or
# an existing text file. if its neither, treats the input as a string
# if no input is given, prompts the user to manually enter input
module CLI
  def self.run
    input = ARGV.empty? ? manual_input : ARGV
    type = check_input_type(input)
    if type == :url
      require_relative 'url_handler'
      # input is either the first argument in argv (the rest doesn't matter)
      # or its a valid url as a string given manually
      input = input.first if input.is_a?(Array)
      URLHandler.enumerable_text(input)
    elsif type == :file
      require_relative 'file_handler'
      # input is either the first argument in argv (the rest doesn't matter)
      # or its a valid file path as a string given manually
      input = input.first if input.is_a?(Array)
      FileHandler.enumerable_text(input)
    else
      require_relative 'string_handler'
      # input is either an array of words that should be joined
      # into a string after having been given in argv, or its
      # just a regular string
      input = input.join(' ') if input.is_a?(Array)
      StringHandler.enumerable_text(input)
    end
  end

  def self.check_input_type(input)
    if input[0].start_with?('http') || (input.is_a?(String) && input.start_with?('http'))
      :url
    elsif input[0].end_with?('.txt') || (input.is_a?(String) && input.end_with?('.txt'))
      :file
    else
      :string
    end
  end

  def self.manual_input
    puts 'No arguments given, enter file name/URL/string to continue'
    gets.chomp
  end

  private_class_method :check_input_type, :manual_input
end
