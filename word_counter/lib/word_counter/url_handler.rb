# frozen_string_literal: true

# used when given input is a suspected url
# (starts with http)
# opens the url as a file for reading and returns an enumerator
# for the text to be read line by line
module URLHandler
  attr_reader :enumerable

  # gets the html content using nokogiri, removes Javascript words,
  # and extract text from the html body element
  def self.enumerable_text(url)
    require 'nokogiri'
    html = url_exists?(url)
    html.css('script', 'link').each(&:remove)
    text = html.at('body').text
    text.each_line
  end

  def self.url_exists?(url)
    uri = URI(url)
    require 'open-uri'
    # uses URI(url).open to avoid using kernel#open
    # which allows piping and poses a security risk
    Nokogiri::HTML(uri.open)
  rescue NameError, SocketError
    puts "#{url} is not a valid URL"
    exit 1
  end

  private_class_method :url_exists?
end
