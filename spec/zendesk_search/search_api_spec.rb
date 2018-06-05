RSpec.describe ZendeskSearch::SearchAPI do
  subject do
    ZendeskSearch::SearchAPI
  end


  describe '#search' do
    # let(:storage_instance) { ZendeskSearch::Load.instance.storage_instance }

    # it 'make request to hash storage to get results' do
    #   allow(storage_instance).to receive(:find_resource) { ['test'] }
    #   subject.search('test_resource', 'term', 'value')
    #   # expect(subject.search('test_resource', 'term', 'value')).to output(/test/).to_stdout
    #   expect(storage_instance).to receive(:find_resource).with("an argument I want")
    # end

  end
end
