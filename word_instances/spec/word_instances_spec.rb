# frozen_string_literal: true

require_relative '../lib/word_instances'

RSpec.describe WordInstances do
  describe '::print_result' do
    it 'prints the number of instances of given word in the database' do
      begin
        expect { WordInstances.print_result }.to output(/\d+ instances of '.+' in \d[.]\d+ seconds/).to_stdout
        # database allows only a single access at a time
      rescue Errno::EAGAIN
        retry
      end
    end
  end
end
