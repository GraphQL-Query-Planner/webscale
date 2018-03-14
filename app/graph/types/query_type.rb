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
    argument :max_id, types.ID
    argument :min_id, types.ID
    argument :receiver_id, types.ID

    resolve -> (_, args, _) {
      id_cond = args[:min_id] && [:max_id] ? { id: args[:min_id]..args[:max_id] } : nil
      receiver_cond = args[:receiver_id] ? { receiver_id: args[:receiver_id] } : nil

      Post.where(receiver_cond).where(id_cond)
    }
  end

  connection :comments, CommentType.connection_type do
    argument :content_id, !types.ID
    argument :content_type, !types.ID

    resolve -> (_, args, _) { Comment.where(content_id: args[:content_id], content_type: args[:content_type]) }
  end

  connection :likes, LikeType.connection_type do
    argument :content_id, !types.ID
    argument :content_type, !types.ID
    argument :user_id, types.ID

    resolve -> (_, args, _) {
      user_cond = args[:user_id] ? { user_id: args[:user_id] } : nil
      Like.ignore_index("index_likes_on_user_id_and_content_id_and_content_type").where(user_cond).where(content_id: args[:content_id], content_type: args[:content_type])
    }
  end

  connection :users, UserType.connection_type do
    argument :first_name, types.String
    argument :last_name, types.String

    resolve -> (_, args, _) {
      first_name_cond = args[:first_name] ? {first_name: args[:first_name]} : nil
      last_name_cond = args[:last_name] ? {last_name: args[:last_name]} : nil

      User.where(first_name_cond).where(last_name_cond)
    }
  end

  field :like, LikeType do
    argument :user_id, !types.ID
    argument :content_id, !types.ID

    resolve -> (_, args, _) { Like.find_by(user_id: args[:user_id], content_id: args[:content_id]) }
  end
end
