RSpec.describe ZendeskSearch::Association do
  subject do
    ZendeskSearch::Association.instance
  end

  describe '#load_config' do
    it 'with successful loading of yaml' do
      subject.load_config('spec/zendesk_search/data')
      expect(subject.association_config.size).to eq(1)
    end

    context 'when error occurs' do
      before do
        allow(subject).to receive(:load_config).and_raise(StandardError)
      end

      it 'raises a StandardError' do
        expect { actual }.to raise_error(StandardError)
      end
    end
  end
end
