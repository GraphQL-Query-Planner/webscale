require 'rails_helper'

describe Graphql::Analyzer::Instrumentation do
  let(:user) { create(:user) }
  let(:query_string) { %|{ user(id: "#{user.to_global_id}") { id } }| }
  let(:analyzer) { Graphql::Analyzer.new(AppSchema) }
  let(:result) do
    res = analyzer.execute(query_string, context: {}, variables: {})
    pp res if res['errors']
    res
  end

  it 'should work' do
    result = analyzer.execute(query_string, context: {}, variables: {})
    expect(result).to eq ''
  end
end
