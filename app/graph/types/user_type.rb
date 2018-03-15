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
    argument :max_id, types.ID
    argument :min_id, types.ID

    resolve -> (user, args, _) {
      if args[:min_id] && [:max_id]
        id_range_condition = { id: args[:min_id]..args[:max_id] }
      else
        id_range_condition = nil
      end

      user.wall.where(id_range_condition)
    }
  end
  field :comments, types[CommentType]
  field :likes, types[LikeType]
end
