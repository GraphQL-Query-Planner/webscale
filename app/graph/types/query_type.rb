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

    resolve -> (_, args, _) {
      if args[:min_id] && [:max_id]
        id_range_condition = { id: args[:min_id]..args[:max_id] }
      else
        id_range_condition = nil
      end

      Post.where(id_range_condition)
    }
  end

  connection :users, UserType.connection_type do
    argument :first_name, types.String
    argument :last_name, types.String

    resolve -> (_, args, _) {
      first_name_condition = args[:first_name] ? {first_name: args[:first_name]} : nil
      last_name_condition = args[:last_name] ? {last_name: args[:last_name]} : nil

      User.where(first_name_condition).where(last_name_condition)
    }
  end

  # This shouldn't be used by the client. It exists for demo purposes
  connection :likes, LikeType.connection_type do
    argument :content_id, !types.ID
    argument :content_type, !types.String
    argument :user_id, types.ID

    resolve -> (_, args, _) {
      content_id = GlobalID::Locator.locate(args[:content_id]).id

      if args[:user_id]
        user_id = GlobalID::Locator.locate(args[:user_id]).id
        user_condition = { user_id: user_id }
      else
        user_condition = nil
      end
      Like.ignore_index("index_likes_on_user_id_and_content_id_and_content_type").where(user_condition).where(content_id: content_id, content_type: args[:content_type])
    }
  end

end
