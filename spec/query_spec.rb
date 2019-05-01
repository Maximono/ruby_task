require 'spec_helper'

RSpec.describe Query do
  let(:query) {  }

  describe '#sort' do
    subject { described_class.new.sort(:city, last_name: :desc) }

    it 'should return self' do
      expect(subject).to be_instance_of(Query)
    end

    it 'should set sort in result hash' do
      expect(subject.result[:sort]).to eq({city: :asc, last_name: :desc})
    end

    it 'should add sort values to existing sort values' do
      subject.sort(:email)

      expect(subject.result[:sort])
        .to eq({city: :asc, last_name: :desc, email: :asc})
    end
  end

  describe '#size' do
    it 'should return self' do
      expect(subject.size(5)).to be_instance_of(Query)
    end

    it 'should set size key in result hash' do
      expect(subject.size(2).result[:size]).to eq(2)
    end

    it 'should replace size value in result hash' do
      subject.size(15)

      expect do
        subject.size(20)
      end.to(change { subject.result[:size] }.from(15).to(20))
    end

    it 'should raise type error' do
      expect do
        subject.size('20')
      end.to raise_error(TypeError, 'wrong argument type')
    end
  end

  describe '#from' do
    it 'should return self' do
      expect(subject.from(5)).to be_instance_of(Query)
    end

    it 'should set from key in result hash' do
      expect(subject.from(2).result[:from]).to eq(2)
    end

    it 'should replace from value in result hash' do
      subject.from(5)

      expect do
        subject.from(10)
      end.to(change { subject.result[:from] }.from(5).to(10))
    end

    it 'should raise type error' do
      expect do
        subject.from('10')
      end.to raise_error(TypeError, 'wrong argument type')
    end
  end

  describe '#filter' do
    subject {described_class.new.filter({status: {eq: 2}})}

    it 'should return self' do
      expect(subject).to be_instance_of(Query)
    end

    it 'should set query key in result hash' do
      expect(subject.result[:query]).to eq({status: {eq: 2}})
    end

    it 'should add filter values to existing filter values' do
      subject.filter({requests: {lt: 4}})

      expect(subject.result[:query])
        .to eq({status: {eq: 2}, requests: {lt: 4}})
    end
  end

  describe '#to_json' do
    it 'should return json' do
      expect(subject.filter({requests: {lt: 4}}).from(5).size(10).to_json).
          to eq("{\"query\":{\"requests\":{\"lt\":4}},\"from\":5,\"size\":10}")
    end
  end
end
