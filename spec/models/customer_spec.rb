# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { Customer.new }

  it 'is valid with valid attributes' do
    customer.assign_attributes(email: 'an@email.com')
    expect(customer.valid?).to be_truthy
  end

  it 'is not valid without an email' do
    expect(customer.valid?).to be_falsey
    expect(customer.errors.full_messages).to include("Email can't be blank")
  end

  it 'is not valid with a wrong email' do
    customer.assign_attributes(email: 'an_email.com')
    expect(customer.valid?).to be_falsey
    expect(customer.errors.full_messages).to include('Email is invalid')
  end
end
