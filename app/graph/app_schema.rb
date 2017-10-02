AppSchema = GraphQL::Schema.define do
  query QueryType

  id_from_object ->(object, _, _) { object.to_global_id.to_s }
  resolve_type -> (type, obj, _ctx) { type.possible_types.detect { |t| t.name == obj.class.name } }
end
