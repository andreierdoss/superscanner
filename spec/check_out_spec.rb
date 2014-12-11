require 'spec_helper'

describe CheckOut do
  let(:rules) { nil }

  describe '#new' do
    subject { CheckOut.new(rules) }

    it { is_expected.to be_an_instance_of CheckOut }
    its(:rules) { is_expected.to be_nil }
    its(:items) { is_expected.to eq([]) }
    its(:total) { is_expected.to eq(0) }
  end

  describe '#scan' do
    let(:check_out) { CheckOut.new(rules) }
    let(:item) { Item.new({sku: 'I', unit_price: 50}) }

    subject { check_out.scan(item) }

    it { expect{ subject }.to change{ check_out.items.count }.from(0).to(1) }
    it { expect{ subject }.to change{ check_out.total }.from(0).to(50) }
  end

  describe '#total' do
    let(:check_out) { CheckOut.new(rules) }
    let(:item1) { Item.new({sku: 'A', unit_price: 50}) }
    let(:item2) { Item.new({sku: 'B', unit_price: 30}) }
    let(:item3) { Item.new({sku: 'A', unit_price: 50}) }
    let(:item4) { Item.new({sku: 'C', unit_price: 20}) }
    let(:item5) { Item.new({sku: 'A', unit_price: 50}) }
    let(:item6) { Item.new({sku: 'D', unit_price: 15}) }
    let(:item7) { Item.new({sku: 'A', unit_price: 50}) }
    let(:item8) { Item.new({sku: 'B', unit_price: 30}) }

    subject { check_out.total }

    before(:each) do
      check_out.scan(item1)
      check_out.scan(item2)
      check_out.scan(item3)
      check_out.scan(item4)
      check_out.scan(item5)
      check_out.scan(item6)
      check_out.scan(item7)
      check_out.scan(item8)
    end

    context 'no rules' do
      it { is_expected.to eq(295) }
    end

    context "3 A's for 130 and 2 B's for 45" do
      let(:rule1) { Rule.new({item_sku: 'A', quantity: 3, bulk_price: 130, start_date: Date.today, end_date: Date.today + 1}) }
      let(:rule2) { Rule.new({item_sku: 'B', quantity: 2, bulk_price: 45, start_date: Date.today - 1, end_date: Date.today}) }
      let(:rules) { [rule1, rule2] }

      it { is_expected.to eq(260) }
    end

    context "invalid pricing rule" do
      let(:invalid_rule) { Rule.new({item_sku: 'A', quantity: 3, bulk_price: 130, start_date: Date.today + 2, end_date: Date.today + 7}) }
      let(:valid_rule) { Rule.new({item_sku: 'B', quantity: 2, bulk_price: 45, start_date: Date.today - 2, end_date: Date.today + 5}) }
      let(:rules) { [invalid_rule, valid_rule] }

      it { is_expected.to eq(280) }
    end
  end
end
