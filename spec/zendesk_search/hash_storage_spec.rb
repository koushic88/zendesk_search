require 'spec_helper'

RSpec.describe ZendeskSearch::HashStorage do
  subject do
    ZendeskSearch::HashStorage.instance
  end

  ZendeskSearch::Load.instance.load_json('spec/zendesk_search/data')
  ZendeskSearch::Association.instance.load_config('spec/zendesk_search/data')

  describe '#resources' do
    it 'returns all the available resources' do
      expect(subject.resources.size).to eq(2)
    end
  end

  describe '#all_search_terms' do
    it 'returns all the search terms for all the resources' do
      expect(subject.all_search_terms).to be_truthy
    end
  end

  describe '#search_terms' do
    it 'returns all the search terms for the given resource' do
      result = subject.search_terms('users_mock')
      expect(result.size).to eq(19)
      expect((result.include? '_id')).to be_truthy
    end

    it 'returns nil for invalid resource' do
      allow(subject).to receive(:resources) { ['test'] }
      result = subject.search_terms('users_mock')
      expect(result).to be_nil
    end
  end

  describe '#find_resource' do
    it 'returns the search results for the given parameters' do
      result = subject.find_resource('users_mock', '_id', '1')
      expect(result).to be_truthy
      expect(result[0]['_id']).to eq(1)
      expect(result[0]['name']).to eq('Francisca Rasmussen')
      expect(result[0]['associated_data']['organization']).to be_truthy
    end

    it 'returns nil when match not found' do
      result = subject.find_resource('users_mock', '_id', '5')
      expect(result).to be_nil
    end

    it 'returns nil when incorrect resource is passed' do
      result = subject.find_resource('incorrect_resource', '_id', '5')
      expect(result).to be_nil
    end
  end
end
