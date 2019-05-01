require 'spec_helper'

RSpec.describe Query do
  let(:query) { described_class.new }

  describe '#sort' do
    before { query.sort(:city, last_name: :desc) }

    it 'should return self' do
      expect(query.sort).to be_instance_of(Query)
    end

    it 'should set sort in result hash' do
      expect(query.result).not_to be_empty
    end

    it 'should add sort values to existing sort values' do
      query.sort(:email)
      expect(query.result[:sort]).to eq({city: :asc,
                                         last_name: :desc,
                                         email: :asc})
    end
  end

  describe '#size' do
    before { query.size(15) }

    it 'should return self' do
      expect(query.size(5)).to be_instance_of(Query)
    end

    it 'should set size key in result hash' do
      expect(query.result).not_to be_empty
    end

    it 'should replace size value in result hash' do
      expect { query.size(20) }.to change { query.result[:size] }.from(15).to(20)
    end

    it 'should raise type error' do
      expect { query.size('20') }.to raise_error(TypeError, 'wrong argument type')
    end
  end

  describe '#from' do
    before { query.from(5) }

    it 'should return self' do
      expect(query.from(10)).to be_instance_of(Query)
    end

    it 'should set from key in result hash' do
      expect(query.result).not_to be_empty
    end

    it 'should replace from value in result hash' do
      expect { query.from(10) }.to change { query.result[:from] }.from(5).to(10)
    end

    it 'should raise type error' do
      expect { query.from('10') }.to raise_error(TypeError, 'wrong argument type')
    end
  end

  describe '#filter' do
    before {query.filter({status: {eq: 2}})}

    it 'should return self' do
      expect(query.filter).to be_instance_of(Query)
    end

    it 'should set query key in result hash' do
      expect(query.result).not_to be_empty
    end

    it 'should add filter values to existing filter values' do
      query.filter({requests: {lt: 4}})
      expect(query.result[:query]).to eq({status: {eq: 2},
                                          requests: {lt: 4}})
    end
  end

  describe '#to_json' do
    it 'should return json' do
      expect(query.filter({requests: {lt: 4}}).from(5).size(10).to_json).
          to eq("{\"query\":{\"requests\":{\"lt\":4}},\"from\":5,\"size\":10}")
    end
  end
end
