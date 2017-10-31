module Graphql
  class Analyzer
    def initialize(graphql_schema)
      @graphql_schema = graphql_schema
      @instrumenter = Graphql::Analyzer::Instrumentation.new
    end

    def execute(*args)
      result = schema.execute(*args)
      result.merge(instrumentation: instrumenter.to_h)  
    end

    private

    attr_reader :graphql_schema, :instrumenter

    def schema
      instrumenter = @instrumenter
      @schema ||= graphql_schema.redefine { instrument(:field, instrumenter) }
    end
  end
end
