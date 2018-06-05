RSpec.describe ZendeskSearch::Load do
  subject do
    ZendeskSearch::Load.instance
  end

  describe '#load_json' do
    it 'with successful parsing of JSON files' do
      subject.load_json('spec/zendesk_search/data')
      expect(subject.storage_instance.data.size).to eq(2)
    end

    it 'no json files found in the directory' do
      expect { subject.load_json('spec/zendesk_search/') }
        .to output(/No json files found in the director/).to_stdout
    end

    it 'fails to parse the json' do
      expect { subject.load_json('spec/zendesk_search/') }
        .to output(/No json files found in the director/).to_stdout
    end

    context 'when error occurs' do
      before do
        allow(subject).to receive(:load_json).and_raise(StandardError)
      end

      it 'raises a StandardError' do
        expect { actual }.to raise_error(StandardError)
      end
    end
  end
end
