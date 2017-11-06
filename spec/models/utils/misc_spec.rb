def path(field_names)
  "{\n#{path_i(field_names.dup, 1)}\n}"
end

def path_i(field_names, i)
  spacing = " " * i * 2
  query_path = ""
  query_path << " {\n" unless i == 1
  query_path << "#{spacing}#{field_names.shift}"

  return query_path if field_names.empty?
  query_path << path_i(field_names, i + 1) << "\n#{spacing}}"
end

def path2(field_names)
  field_names.first + path2_i(field_names[1..-1].dup)
end

def path2_i(field_names)
  return if field_names.empty?
  query_path = " { #{field_names.shift}"
  query_path << path2_i(field_names) if field_names.any?
  query_path << ' }'
end

require 'rails_helper'

describe Graphql::Analyzer do
  let(:query_path1) { %w(userA posts) }
  let(:query_path2) { %w(userA posts id) }
  let(:query_fragment1) do
    <<~GQL
    {
      userA {
        posts
      }
    }
    GQL
  end
  let(:query_fragment2) do
    <<~GQL
    {
      userA {
        posts {
          id
        }
      }
    }
    GQL
  end
  let(:query_fragment3) { "userA { posts }" }
  let(:query_fragment4) { "userA { posts { id } }" }


  it 'should work' do
    puts query_fragment1, query_fragment2
    expect(path(query_path1)).to eq query_fragment1.chomp
    expect(path(query_path2)).to eq query_fragment2.chomp
  end

  it 'should work2' do
    puts query_fragment3, query_fragment4
    expect(path2(query_path1)).to eq query_fragment3.chomp
    expect(path2(query_path2)).to eq query_fragment4.chomp
  end
end
