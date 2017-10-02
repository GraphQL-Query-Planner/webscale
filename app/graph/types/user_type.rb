UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'A user'
  global_id_field :id

  field :first_name, !types.String
  field :last_name, types.String
  field :email, !types.String
end
