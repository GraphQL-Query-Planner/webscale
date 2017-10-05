CommentType = GraphQL::ObjectType.define do
  name 'Comment'
  description 'A comment a user left on some content.'
  global_id_field :id

  field :author, !UserType, property: :user
  field :content, !ContentType
end
