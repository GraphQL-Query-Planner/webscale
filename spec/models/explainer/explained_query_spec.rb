require "rails_helper"
require 'explainer/parser'

describe Explainer::ExplainedQuery do

  it 'the query is indexed' do
    output = Post.where(author_id: 1).explain
    result = Explainer::Parser.parse(output)
    expect(result.queries.first).to be_indexed
  end

  it 'the query isnt indexed' do
    output = Post.where(author_id: 1).from("#{Post.table_name} IGNORE INDEX(index_posts_on_author_id)").explain
    result = Explainer::Parser.parse(output)
    expect(result.queries.first).not_to be_indexed
  end

  it 'the query uses a full table scan' do
    output = Comment.where(content_type: 'Post').from("#{Comment.table_name} IGNORE INDEX(index_comments_on_content_type_and_content_id)").explain
    result = Explainer::Parser.parse(output)
    expect(result.queries.first).to be_full_table_scan
  end

  it 'the query does not use a full table scan' do
    output = Comment.where(content_type: 'Post').explain
    result = Explainer::Parser.parse(output)
    expect(result.queries.first).not_to be_full_table_scan
  end
end
