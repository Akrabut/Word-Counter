# frozen_string_literal: true

# used when given input is a suspected file name
# (ends with .txt)
# opens the file for reading and returns an enumerator
# for the text to be read line by line
module FileHandler
  def self.enumerable_text(name)
    File.open(find_file_in_system(name), 'r').lazy
  rescue Errno::ENOENT
    puts "File with name #{name} not found"
    exit 1
  end

  # NOTE: locate command relies on a database called mlocate.
  # The said database needs to be updated regularly for the command utility to work
  # if an existing file is not found, run `sudo updatedb`
  def self.find_file_in_system(name)
    `locate #{name} -n 1`.chomp
  end

  private_class_method :find_file_in_system
end
