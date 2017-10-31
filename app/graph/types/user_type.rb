UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'A user'
  global_id_field :id

  field :first_name, !types.String
  field :last_name, types.String
  field :email, !types.String

  field :posts, types[PostType]
  field :wall, types[PostType]
  field :comments, types[CommentType]
  field :likes, types[LikeType]
end
