module APIContext
  extend ActiveSupport::Concern

  included do
    protect_from_forgery with: :null_session
  end

  protected

    def build_api_context
      {
        current_user: current_user,
        current_ability: current_ability
      }
    end

    def authenticated?(operation_name)
      return true if operation_name == "SignIn"
      return false unless request.headers['Authorization'].present?
      auth_header = request.headers['Authorization']
      token = auth_header.strip.match(/^Bearer\s+(.*?)$/)
      return false unless auth_header.present? && token.present?
      @user = Member.find_for_token_authentication(auth_token: token[1])
      @user.present?
    end

    def current_user
      @user
    end

    def render_unauthorized
      head :unauthorized
    end

end