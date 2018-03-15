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

  field :like, LikeType do
    argument :user_id, !types.ID
    argument :content_id, !types.ID

    resolve -> (_, args, _) {
      user_id = GlobalID::Locator.locate(args[:user_id]).id
      content_id = GlobalID::Locator.locate(args[:content_id]).id
      Like.find_by(user_id: user_id, content_id: content_id)
    }
  end
end
