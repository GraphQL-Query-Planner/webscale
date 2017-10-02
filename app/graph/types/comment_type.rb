CommentType = GraphQL::ObjectType.define do
  name 'Comment'
  description 'A comment that a user left on a post.'
  global_id_field :id

  field :author, !UserType
  field :content, !ContentType
end
