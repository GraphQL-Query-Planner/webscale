require 'rails_helper'
require 'explainer/parser'

describe Comment, type: :model do
  let!(:post) { create(:post) }
  let!(:posts) { FactoryGirl.create_list(:post, 100) }
  let!(:post_comments) { FactoryGirl.create_list(:post_comment, 5, content: post) }
  let!(:post_comments2) { FactoryGirl.create_list(:post_comment, 50) }
  let!(:photo_comments) { FactoryGirl.create_list(:photo_comment, 100, content: post) }
  # need the extras so that index is used

  it "should use index for content_type of comment" do
    query_string = %|
      {
        comments(content_id: "gid://webscale/Post/#{post.id}", content_type: "Post") {
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
    explained_query = results.last.explained_queries.first

    expect(explained_query).not_to be_full_table_scan
    expect(explained_query).to be_indexed

  end
end
