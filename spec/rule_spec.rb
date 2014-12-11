require 'spec_helper'

describe Rule do
  let(:attributes) { {item_sku: 'Q', quantity: 3, bulk_price: 130, start_date: Date.today, end_date: Date.today} }

  describe '#new' do
    subject { Rule.new(attributes) }

    it { is_expected.to be_an_instance_of Rule }
    its(:item_sku) { is_expected.to eq('Q') }
    its(:quantity) { is_expected.to eq(3) }
    its(:bulk_price) { is_expected.to eq(130) }
    its(:discounted_unit_price) { is_expected.to eq(43.333333333333336) }
    its(:start_date) { is_expected.to eq(Date.today) }
    its(:end_date) { is_expected.to eq(Date.today) }
  end

  describe '#apply_to' do
    let(:rule) { Rule.new({item_sku: 'B', quantity: 2, bulk_price: 45}) }
    let(:item1) { Item.new({sku: 'B', unit_price: 50}) }
    let(:item2) { Item.new({sku: 'A', unit_price: 30}) }
    let(:item3) { Item.new({sku: 'B', unit_price: 50}) }
    let(:items) { [item1, item2, item3] }

    subject { rule.apply_to(items) }

    it { expect(subject.map(&:discounted_unit_price)).to eq([22.5, nil, 22.5]) }
  end

  describe '#valid?' do
    let(:rule) { Rule.new({item_sku: 'B', quantity: 2, bulk_price: 45, start_date: start_date, end_date: end_date}) }

    subject { rule.valid? }

    context 'price ended' do
      let(:start_date) { Date.today - 7 }
      let(:end_date) { Date.today - 2 }

      it { is_expected.to be_falsey }
    end

    context 'price ongoing' do
      let(:start_date) { Date.today }
      let(:end_date) { Date.today + 2 }

      it { is_expected.to be_truthy }
    end
  end
end
