PhotoType = GraphQL::ObjectType.define do
  name 'Photo'
  description 'A photo uploaded by a user'
  global_id_field :id

  field :post, !PostType
  field :photo_url, !types.String
end
