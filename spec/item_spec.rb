require 'spec_helper'

describe Item do
  let(:attributes) { {sku: 'Q', unit_price: 101} }

  describe '#new' do
    subject { Item.new(attributes) }

    it { is_expected.to be_an_instance_of Item }
    its(:sku) { is_expected.to eq('Q') }
    its(:unit_price) { is_expected.to eq(101) }
  end
end
