QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root for this schema'

  field :simple, !types.String, resolve: -> (_, args, _) { SecureRandom.uuid }

  field :node, GraphQL::Relay::Node.field
  field :nodes, GraphQL::Relay::Node.plural_field

  field :search, types[!SearchResultType] do
    argument :query, !types.String

    resolve -> (_, args, _) do
      response = Elasticsearch::Model.search(
        args[:query],
        SearchRecordType.possible_types.map(&:name).map(&:constantize)
      )
      response.results.to_a.map(&:to_hash)
    end
  end

  field :comments, types[CommentType] do
    argument :content_type, !types.String

    resolve -> (_, args, _) { Comment.where(content_type: args[:content_type]) }
  end

  field :like, LikeType do
    argument :user_id, !types.ID
    argument :content_id, !types.ID

    resolve -> (_, args, _) { Like.find_by(user_id: args[:user_id], content_id: args[:content_id]) }
  end

  field :group, GroupType do
    argument :id, !types.ID

    resolve -> (_, args, _) { Group.find(args[:id]) }
  end
end
