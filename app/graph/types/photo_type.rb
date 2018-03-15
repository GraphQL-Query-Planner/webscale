PhotoType = GraphQL::ObjectType.define do
  name 'Photo'
  description 'A photo uploaded by a user'

  implements GraphQL::Relay::Node.interface

  global_id_field :id

  field :post, !PostType
  field :photo_url, !types.String
  field :comments, !types[CommentType]
  field :likes, !types[LikeType]
end
