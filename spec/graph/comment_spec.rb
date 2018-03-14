require 'rails_helper'
require 'explainer/parser'

describe Comment, type: :model, elasticsearch: true do
  let!(:post) { create(:post) }
  let!(:post_comments) { FactoryGirl.create_list(:post_comment, 5, content: post) }

  it "should not use index for content_type of comment" do
    query_string = %|
      {
        comments(content_id: #{post.id}, content_type: "Post") {
          edges{
            node {
              id
            }
          }
        }
      }
    |

    queries = ActiveRecord::Base.collecting_queries_for_explain do
      AppSchema.execute(query_string, context: {}, variables: {})
    end
    results = queries.map do |query|
      explain_output = ActiveRecord::Base.exec_explain([query])
      result = Explainer::Parser.parse(explain_output)
    end
    explained_query = results.first.explained_queries.first

    expect(explained_query).not_to be_indexed
    expect(explained_query).to be_full_table_scan
  end
end
