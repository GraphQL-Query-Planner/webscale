GroupType = GraphQL::ObjectType.define do
  name 'Group'
  description 'A group'

  field :name, !types.String
end
