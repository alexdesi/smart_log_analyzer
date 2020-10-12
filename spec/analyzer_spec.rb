# frozen_string_literal: true

require 'rspec'
require_relative '../lib/log_analyzer'

describe LogAnalyzer do
  let(:sample_data) do
    <<~HEREDOC
      /a 126.318.035.038
      /b 184.123.665.067
      /a 184.123.665.067
      /c 444.701.448.104
      /c 929.398.951.889
      /a 629.198.901.283
    HEREDOC
  end

  describe '#views' do
    it 'returns a Hash containing the visits' do
      analyzer = described_class.new(sample_data)
      expect(analyzer.views).to be_a(Hash)
    end
  end
end
