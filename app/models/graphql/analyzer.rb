module Graphql
  class Analyzer
    def initialize(graphql_schema)
      @graphql_schema = graphql_schema
    end

    def execute(*args)
      instrumenter = Instrumentation.new
      result = schema(instrumenter).execute(*args)
      result.merge(instrumentation: instrumenter.to_h)
    end

    private

    attr_reader :graphql_schema

    def schema(instrumenter)
      graphql_schema.redefine { instrument(:field, instrumenter) }
    end
  end
end
