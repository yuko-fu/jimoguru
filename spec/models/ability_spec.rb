require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  describe '権限のテスト' do
    context '管理者ユーザーの場合' do
      let(:admin_user) { User.new(name: '管理者', email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true) }
      let(:ability) { Ability.new(admin_user) }

      it 'Rails Adminへのアクセスができる' do
        expect(ability).to be_able_to(:access, :rails_admin)
      end

      it 'すべてのデータに対して管理機能が利用できる' do
        expect(ability).to be_able_to(:manage, :all)
      end
    end

    context '一般ユーザーの場合' do
      let(:user) { User.new(name: '一般ユーザー', email: 'user@example.com', password: 'password', password_confirmation: 'password', admin: false) }
      let(:ability) { Ability.new(user) }

      it 'Rails Adminへのアクセスができない' do
        expect(ability).not_to be_able_to(:access, :rails_admin)
      end

      it 'すべてのデータに対して管理機能が利用できない' do
        expect(ability).not_to be_able_to(:manage, :all)
      end
    end
  end
end