module Graphql
  class Analyzer
    class Instrumentation
      def initialize
        @results = {}
      end

      def instrument(type, field)
        new_resolve_proc = analyze_resolve_proc(type, field)
        field.redefine do
          resolve(new_resolve_proc)
        end
      end

      def to_h
        results.map { |k1, v1| [k1, v1.map { |k2, v2| [k2, v2.map(&:to_h)] }] }.to_h
      end

      private

      attr_reader :results

      def analyze_resolve_proc(type, field)
        -> (obj, args, ctx) do
          queries = ActiveRecord::Base.collecting_queries_for_explain do
            field.resolve_proc.call(obj, args, ctx)
          end

          if queries.any?
            explain_output = ActiveRecord::Base.exec_explain(queries)
            result = Explainer::Parser.parse(explain_output)
            results[type.name.to_sym] ||= {}
            results[type.name.to_sym][field.name.to_sym] ||= []
            results[type.name.to_sym][field.name.to_sym] << result
          end

          field.resolve_proc.call(obj, args, ctx)
        end
      end
    end
  end
end
