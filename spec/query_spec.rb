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
end
