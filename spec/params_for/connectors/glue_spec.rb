require 'spec_helper'

describe DummyController, type: :controller do

  class SomeResource
    include ActiveModel::Validations

    attr_accessor :foo
    validates_numericality_of :foo, odd: true
  end

  let(:resource) do
    resource = SomeResource.new
    resource.foo = 1
    resource
  end

  let(:foo){nil}

  let(:valid_params){ {id: 1, foo:1, bar:'yo'} }
  let(:invalid_params){ {foo:1, bar:'yo'} }


  describe '#validate_params' do
    it 'should be true for valid params' do
      allow(subject).to receive(:params).and_return(valid_params)
      expect(subject.validate_params(:dummy)).to be true
    end
    it 'should be false for invalid params' do
      allow(subject).to receive(:params).and_return(invalid_params)
      expect(subject.validate_params(:dummy)).to be false
    end
  end

  describe '#params_valid?' do
    it 'should be true for valid params' do
      allow(subject).to receive(:params).and_return(valid_params)
      expect(subject.params_valid?(:dummy)).to be true
    end
    it 'should be false for invalid params' do
      allow(subject).to receive(:params).and_return(invalid_params)
      expect(subject.params_valid?(:dummy)).to be false
    end
  end

  describe '#all_valid?' do
    before do
      allow(subject).to receive(:params).and_return(valid_params)
    end

    it 'should call resources_valid?' do
      expect(subject).to receive(:resources_valid?).with(resource)
      subject.all_valid?(:dummy, resource)
    end

    it 'should call params_valid?' do
      expect(subject).to receive(:params_valid?).with(:dummy)
      subject.all_valid?(:dummy, resource)
    end

    it 'is true if all resources and params are true' do
      expect(resource.valid?).to be true
      expect(subject.params_valid?(:dummy)).to be true
      expect(subject.all_valid?(:dummy, resource)).to be true
    end

    it 'is false if any resources and params are false' do
      resource.foo = 2
      expect(resource.valid?).to be false
      expect(subject.params_valid?(:dummy)).to be true
      expect(subject.all_valid?(:dummy, resource)).to be false
    end
  end

  describe '#collect_errors' do
    before do
      allow(subject).to receive(:params).and_return(invalid_params)
      resource.foo = 2
    end

    it 'aggregates errors from params and resources' do
      errors = subject.collect_errors(:dummy, resource)
      expect(errors).to include(:foo)
      expect(errors).to include(:id)
    end
  end
end
