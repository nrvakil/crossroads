module ErrorHandlers
  extend ActiveSupport::Concern

  def render_bad_request(e)
    render json: { meta: { success: false, errors: e.message } }, status: :bad_request
  end

  def render_not_found(e)
    render json: { meta: { success: false, errors: e.message } }, status: :not_found
  end

  def render_unprocessable_entity(e)
    render json: { meta: { success: false, errors: e.message } }, status: :unprocessable_entity
  end

  def render_not_acceptable(e)
    render json: { meta: { success: false, errors: e.message } }, status: :not_acceptable
  end

  def render_forbidden(e)
    render json: { meta: { success: false, errors: e.message } }, status: :forbidden
  end

  def render_service_not_available(e)
    render json: { meta: { success: false, errors: e.message } }, status: :service_unavailable
  end
end
