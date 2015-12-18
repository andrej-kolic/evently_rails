module Api
  module V1

    class Api::V1::BaseController < ApplicationController
      include Pundit
      include ActiveHashRelation

      protect_from_forgery with: :null_session
      rescue_from Pundit::NotAuthorizedError, with: :unauthorized!

      before_action :destroy_session


      def destroy_session
        request.session_options[:skip] = true
      end

      # 404

      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      def not_found
        return api_error(status: 404, errors: 'Not found')
      end


      #

      attr_accessor :current_user

      def authenticate_user!
        token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

        username = options.blank?? nil : options[:username]
        user = username && User.find_by(username: username)

        if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
          @current_user = user
        else
          return unauthenticated!
        end
      end



      protected

      def unauthenticated!
        response.headers['WWW-Authenticate'] = "Token realm=Application"
        render json: { error: 'Bad credentials' }, status: 401
      end


      def unauthorized!
        render json: { error: 'not authorized' }, status: 403
      end



      def api_error(status: 500, errors: [])
        unless Rails.env.production?
          puts errors.full_messages if errors.respond_to? :full_messages
        end
        head status: status and return if errors.empty?

        render json: jsonapi_format(errors).to_json, status: status
      end



      private

      def jsonapi_format(errors)
        return errors if errors.is_a? String
        errors_hash = {}
        errors.messages.each do |attribute, error|
          array_hash = []
          error.each do |e|
            array_hash << {attribute: attribute, message: e}
          end
          errors_hash.merge!({ attribute => array_hash })
        end

        return errors_hash
      end


    end

  end
end
