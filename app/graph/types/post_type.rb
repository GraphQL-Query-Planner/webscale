PostType = GraphQL::ObjectType.define do
  name 'Post'
  description 'A post made by a user'

  implements GraphQL::Relay::Node.interface

  global_id_field :id

  field :body, !types.String
  field :author, !UserType
  field :receiver, !UserType
  field :likes, !types[LikeType] do
    resolve -> (post, args, _) { post.likes }
  end
end
