module Graphql
  class Analyzer
    class Instrumentation
      attr_reader :results

      def initialize
        @results = []
      end

      def instrument(_type, field)
        new_resolve_proc = analyze_resolve_proc(_type, field)
        field.redefine do
          resolve(new_resolve_proc)
        end
      end

      def to_h
        results.map do |field, result|
          result.to_h.merge(selection: field)
        end
      end

      private

      def analyze_resolve_proc(_type, field)
        -> (obj, args, ctx) do
          queries = ActiveRecord::Base.collecting_queries_for_explain do
            records = field.resolve_proc.call(obj, args, ctx)
            records.to_a if records.respond_to?(:to_a)
          end

          if queries.any?
            explain_output = ActiveRecord::Base.exec_explain(queries)
            result = Explainer::Parser.parse(explain_output)
            result.selection = selection(ctx.path)
            results << result
          end

          field.resolve_proc.call(obj, args, ctx)
        end
      end

      def selection(field_names)
        field_names.first + selection_i(field_names[1..-1].dup)
      end
      
      def selection_i(field_names)
        return '' if field_names.empty?
        query_path = " { #{field_names.shift}"
        query_path << selection_i(field_names) if field_names.any?
        query_path << ' }'
      end
    end
  end
end
