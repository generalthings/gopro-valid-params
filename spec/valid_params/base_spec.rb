require 'spec_helper'

describe ValidParams::Base do

  let(:validator_klass) do
    unless defined?(DummyValidator)
      class DummyValidator < ValidParams::Base

        validates :type, inclusion: {in: %w{task project}, allow_nil: true}
      end
    end
    DummyValidator
  end

  context 'initialization' do
    let(:validator) do
      validator_klass.new(id: 'asd', name: 3, new_param: 'ads')
    end

    it 'has getters for params' do
      expect(validator.id).to eq('asd')
      expect(validator.name).to eql(3)
      expect(validator.new_param).to eq('ads')
    end

    it "returns nil for params that it doesn't have" do
      expect(validator.non_existent).to be(nil)
    end
  end

  context 'handling validation errors' do
    let(:validator) do
      validator_klass.new type: 'job'
    end

    it 'is not valid if theres a bad attribute' do
      expect(validator.valid?).to be(false)
    end

    it 'contains appropriate errors' do
      validator.valid?
      expect(validator.errors).to include(:type)
    end
  end

  context 'class is valid' do
    let(:validator) do
      validator_klass.new type: 'task'
    end

    it 'should be valid' do
      expect(validator.valid?).to be(true)
    end

    it 'should not have errors' do
      validator.valid?
      expect(validator.errors.count).to be 0
    end
  end
end
