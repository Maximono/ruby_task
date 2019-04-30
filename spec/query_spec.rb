require 'spec_helper'

RSpec.describe Query do
  let(:query) { described_class.new }
  before { query.sort(:city, last_name: :desc) }

  describe '#sort' do
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
end
