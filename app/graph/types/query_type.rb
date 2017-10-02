QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root for this schema'

  field :simple, !types.String, resolve: -> (_, args, _) { SecureRandom.uuid }

  field :post, PostType, resolve: ActiveRecordResolver do
    argument :id, !types.ID
  end

  field :photo, PhotoType, resolve: ActiveRecordResolver do
    argument :id, !types.ID
  end

  field :comment, CommentType, resolve: ActiveRecordResolver do
    argument :id, !types.ID
  end

  field :user, UserType, resolve: ActiveRecordResolver do
    argument :id, !types.ID
  end

  field :like, LikeType do
    argument :user_id, !types.ID
    argument :content_id, !types.ID

    resolve -> (_, args, _) { Like.find_by(user_id: args[:user_id], content_id: args[:content_id]) }
  end
end
