require 'rails_helper'

describe Graphql::Analyzer do
  let(:user) { create(:user) }
  let(:query_string) { %|{ user(id: "#{user.to_global_id}") { id } }| }
  let(:analyzer) { Graphql::Analyzer.new(AppSchema) }
  let(:result) do
    res = analyzer.execute(query_string, context: {}, variables: {})
    pp res if res.key?('errors')
    res
  end

  it 'should work' do
    expect(result).to eq ''
  end
end
