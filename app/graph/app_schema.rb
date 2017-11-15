AppSchema = GraphQL::Schema.define do
  query QueryType

  id_from_object ->(object, _, _) { object.to_global_id.to_s }
  object_from_id -> (id, _ctx) { GlobalID::Locator.locate(id) }
  resolve_type -> (type, obj, _ctx) do
    if type.respond_to?(:possible_types)
      type.possible_types.detect { |t| t.name == obj.class.name }
    else
      "#{obj.class}Type".constantize
    end
  end
end
