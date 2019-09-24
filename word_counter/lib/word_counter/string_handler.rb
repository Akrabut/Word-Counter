# frozen_string_literal: true

# used when given input is neither a file name nor url
# returns an enumerator for the string text to be read
# line by line
module StringHandler
  def self.enumerable_text(str)
    str.each_line
  end
end
