# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability do
  subject { described_class.new(user, token) }

  let(:user) { nil }
  let(:token) { nil }

  describe 'with a token' do
    let(:org1) { FactoryBot.create(:organization) }
    let(:org2) { FactoryBot.create(:organization) }
    let(:token) { JWT.encode({ jti: 'anything' }, Settings.jwt.secret, Settings.jwt.algorithm) }

    before do
      AllowlistedJwt.create(resource: org1, jti: 'anything')
    end

    it { is_expected.to be_able_to(:read, org1) }
    it { is_expected.to be_able_to(:create, Upload.new(organization: org1)) }

    it { is_expected.not_to be_able_to(:read, org2) }
    it { is_expected.not_to be_able_to(:create, Upload.new(organization: org2)) }
  end

  describe 'with a user' do
    context 'with an admin' do
      let(:user) { FactoryBot.create(:admin) }

      it { is_expected.to be_able_to(:manage, :all) }
    end

    context 'when a non-admin user' do
      let(:user) { User.new }

      it { is_expected.to be_able_to(:read, FactoryBot.create(:organization)) }
      it { is_expected.not_to be_able_to(:read, Upload.new) }
      it { is_expected.not_to be_able_to(:read, Batch.new) }
      it { is_expected.not_to be_able_to(:read, Stream.new) }
    end
  end
end
