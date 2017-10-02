LikeType = GraphQL::ObjectType.define do
  name 'Like'
  description 'An association between a user and piece of content that represents the user liking the content.'

  field :user, !UserType
  field :content, !ContentType
end
