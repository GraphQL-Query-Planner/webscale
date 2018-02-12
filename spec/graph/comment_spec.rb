require 'rails_helper'
require 'explainer/parser'

describe Comment, type: :model do
  let!(:post_comments) { FactoryGirl.create_list(:post_comment, 5) }
  let!(:photo_comments) { FactoryGirl.create_list(:photo_comment, 3) }

  it "should not use index for content_type of comment" do
    query_string = %|
      {
        comments(content_type: "Post") {
          id
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