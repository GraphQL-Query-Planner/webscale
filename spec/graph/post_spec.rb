require 'rails_helper'
require 'explainer/parser'

describe Post, type: :model do
  let!(:user) { create(:user) }
  let!(:posts) { FactoryGirl.create_list(:post, 5, author: user) }

  it "should make N+1 queries for the authors of posts" do
    query_string = %|
      {
        node(id: "#{user.to_global_id}") {
          ...on User {
            id
            posts {
              author {
                id
              }
            }
          }
        }
      }
    |

    expect(user.posts.count).to eq 5
    queries = ActiveRecord::Base.collecting_queries_for_explain do
      AppSchema.execute(query_string, context: {}, variables: {})
    end

    expect(queries.count).to eq 7 # 1 for original user, 1 for posts, 5 for each post author.
  end
end
