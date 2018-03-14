UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'A user'

  implements GraphQL::Relay::Node.interface

  global_id_field :id

  field :first_name, !types.String
  field :last_name, types.String
  field :email, !types.String

  field :posts, types[PostType]
  field :wall, types[PostType] do
    resolve -> (user, _, _) do
      AssociationLoader.for(:wall).load(user).then do
        user.wall
      end
    end
  end
  field :comments, types[CommentType]
  field :likes, types[LikeType]
end
