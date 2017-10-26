require "rails_helper"
require 'explainer/parser'

describe Explainer::Parser do
  it 'produces an explainer result' do
    explain_output = Post.where(author_id: 1).explain
    expect(Explainer::Parser.parse(explain_output)).to be_kind_of Explainer::Result
  end
end
