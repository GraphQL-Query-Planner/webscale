LikeType = GraphQL::ObjectType.define do
  name 'Like'
  description 'An association between a user and piece of content that represents the user liking the content.'

  implements GraphQL::Relay::Node.interface

  global_id_field :id

  field :user, !UserType
  field :content, !ContentType
end
