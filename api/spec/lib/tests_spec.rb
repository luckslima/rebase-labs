require 'spec_helper'

RSpec.describe Tests do
  let(:conn) do
    PG.connect(
      dbname: 'test_database',
      user: 'postgres',
      password: 'password',
      host: 'db'
    )
  end

  let(:tests) { Tests.new(conn) }

  describe '#all' do
    it 'returns all tests grouped by token' do
      result = tests.all

      expect(result).to be_an_instance_of(Array)
      expect(result.length).to eq 1
      expect(result.first).to have_key("result_token")
      expect(result.first).to have_key("doctor")
      expect(result.first["doctor"]).to have_key("crm")
    end
  end

  describe '#find_by_token' do
    context 'when the token exists' do
      it 'returns a specific test by token' do
        token = 'IQCZ17'
        result = tests.find_by_token(token)

        expect(result).to have_key("result_token")
        expect(result["result_token"]).to eq(token)
        expect(result).to have_key("doctor")
        expect(result["doctor"]).to have_key("crm")
      end
    end

    context 'when the token does not exist' do
      it 'returns nil' do
        token = '000000'
        result = tests.find_by_token(token)

        expect(result).to be_nil
      end
    end
  end
end
