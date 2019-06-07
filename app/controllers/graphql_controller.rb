class GraphqlController < ApplicationController
  include APIContext
  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = get_operation_name(query)
    unless operation_name.present?
      return render_error("Please provide an operation name for the following query: #{query}")
    end
    return render_unauthorized unless authenticate(operation_name)
    context = build_api_context
    result = FetchApiSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { error: { message: e.message, backtrace: e.backtrace }, data: {} }, status: 500
  end

  def get_operation_name(query)
    GraphQL.parse(query).definitions.first.name
  end

  def render_error(message)
    render json: { errors: [message] }, status: 422
  end
end
