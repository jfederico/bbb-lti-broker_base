# Helpers are used to generalize the app, but this one makes use of some external helpers
require 'bbb_lti_broker/helpers'

# Helpers for the application
module ApplicationHelper
  include BbbLtiBroker::Helpers

  CAP_TO_DESCRIPTIONS = {
    'accountNavigation' => 'Account Navigation',
    'courseNavigation' => 'Course Navigation',
    'assignmentSelection' => 'Assignment Selection',
    'linkSelection' => 'Link Selection'
  }

  def display_cap(cap)
    if CAP_TO_DESCRIPTIONS.keys.include? cap
      CAP_TO_DESCRIPTIONS[cap]
    else
      cap
    end
  end

  def log_hash(h)
    puts "*" * 100
    puts ( h.map{ |k,v| "#{k} => #{v}" }.sort )
    puts "*" * 100
  end

  class CustomError < StandardError;
    attr_reader :error
    def initialize(error = :unknown)
      @error = error
    end
  end

  def lti_authorized_application
    raise CustomError.new(:missing_app) unless params.key?(:app)
    raise CustomError.new(:not_found) unless params[:app] == 'default' || authorized_tools.key?(params[:app])
  end

  def lti_secret(key)
    tool = RailsLti2Provider::Tool.find_by_uuid(key)
    return tool.shared_secret if tool
  end

  def lti_app(name)
    app = Doorkeeper::Application.where(name: name).first
    app.attributes.select { |key, value| ['name', 'uid', 'secret', 'redirect_uri'].include?(key) }
  end

  def lti_icon(app_name)
    uri = URI.parse(view_context.image_url('icon.svg'))
    path_base = uri.path.sub('assets/icon.svg', '')
    unless app_name == 'default'
      begin
        app = lti_app(app_name)
        uri = URI.parse(app['redirect_uri'])
        path_base = uri.path.sub('auth/bbbltibroker/callback', app_name) + '/'
      rescue
      end
    end
    "http://#{uri.host}#{path_base + 'assets/icon.svg'}"
  end

  def authorized_tools
    tools = Doorkeeper::Application.all.select("id, name, uid, secret, redirect_uri").to_a.map { |app| [app.name, app.attributes] }.to_h
    tools['default'] = {}
    tools
  end
end
