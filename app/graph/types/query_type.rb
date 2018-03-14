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

  connection :posts, PostType.connection_type do
    argument :receiver_id, types.ID

    resolve -> (_, args, _) {
      if args[:receiver_id]
        Post.where(receiver_id: args[:receiver_id])
      else
        Post.all
      end
    }
  end

  connection :comments, CommentType.connection_type do
    argument :content_id, !types.ID
    argument :content_type, !types.ID

    resolve -> (_, args, _) { Comment.where(content_id: args[:content_id], content_type: args[:content_type]) }
  end

  connection :users, UserType.connection_type do
    resolve -> (_, args, _) { User.all }
  end

  field :like, LikeType do
    argument :user_id, !types.ID
    argument :content_id, !types.ID

    resolve -> (_, args, _) { Like.find_by(user_id: args[:user_id], content_id: args[:content_id]) }
  end
end
