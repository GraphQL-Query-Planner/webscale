class GraphqlController < ApiController
  def query
    execute_query(AppSchema)
  end

  def analyze
    execute_query(analyze_schema)
  end

  private

  def execute_query(schema)
    query_variables = ensure_hash(params[:variables])
    result = schema.execute(params[:query], variables: query_variables)
    render json: result
  end

  def analyze_schema
    @analyze_schema ||= Graphql::Analyzer.new(AppSchema)
  end

  def ensure_hash(query_variables)
    if query_variables.blank?
      {}
    elsif query_variables.is_a?(String)
      JSON.parse(query_variables)
    else
      query_variables
    end
  end
end
