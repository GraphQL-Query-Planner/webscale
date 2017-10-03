class GraphqlController < ApiController
  def query
    query_variables = ensure_hash(params[:variables])
    result = AppSchema.execute(params[:query], variables: query_variables)
    render json: result
  end

  private

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
