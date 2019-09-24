# frozen_string_literal: true

require_relative '../../lib/word_counter/url_handler'

RSpec.describe URLHandler do
  describe '::enumerable_text' do
    it 'does not blow up when the url is not found' do
      expect(URLHandler.enumerable_text('https://somebullshiturl.thisdoesntexist.rspec')).to not_raise(SocketError)
    end

    it "parses the URL body element's text using nokogiri, and returns an each_line enumerable of the text" do
      expect(URLHandler.enumerable_text('https://makers.lemonade.com').is_a?(Enumerable)).to eq(true)
    end
  end
end
