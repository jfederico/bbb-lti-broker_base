BbbLtiBroker::Application.routes.draw do

  #scope Rails.configuration.relative_url_root + '/(:tenant)', :defaults => {:tenant => "default"} do
  scope Rails.configuration.relative_url_root do
    namespace :api do
      namespace :v1 do
        get 'sso/launch/:token', to: 'sso#validate_launch', as: :sso_launch
        get 'users/:id', to: 'users#show', as: :users
        get 'user', to: 'users#show', as: :user
        resources 'keys'
      end
    end

    use_doorkeeper do
      # Including 'skip_controllers :application' disables the controller for managing external applications
      #   [http://example.com/:root/:tenant/oauth/applications]
      skip_controllers :applications unless Rails.configuration.lti_developer_mode_enabled
    end

    post 'callback', to: 'collaboration_callbacks#confirm_url'
    delete 'callback', to: 'collaboration_callbacks#confirm_url'

    resources :tool_proxy, only: [:create]

    #scope "/(:tenant)", :defaults => {:tenant => "default"} do
    scope "/:tenant", :defaults => {:tenant => "default"} do
      scope "/:app", :defaults => {:app => Rails.configuration.lti_default_tool} do
        get '/', to: 'guide#home'
        get 'guide', to: 'guide#home'
        get 'xml_config', to: 'guide#xml_config', as: :xml_config
        get 'xml_builder', to: 'guide#xml_builder', as: :xml_builder if Rails.configuration.lti_developer_mode_enabled

        post 'messages/blti', to: 'message#basic_lti_launch_request', as: 'blti_launch'
        post 'messages/content-item', to: 'message#content_item_selection', as: 'content_item_request_launch'
        post 'messages/content-item', to: 'message#basic_lti_launch_request', as: 'content_item_launch'
        post 'messages/signed_content_item_request', to: 'message#signed_content_item_request'

        post 'register', to: 'registration#register', as: :tool_registration
        post 'reregister', to: 'registration#register', as: :tool_reregistration
        post 'submit_capabilities', to: 'registration#save_capabilities', as: 'save_capabilities'
        get  'submit_proxy/:registration_uuid', to: 'registration#submit_proxy', as: 'submit_proxy'

        get  'launch', to: 'apps#index', as: :lti_apps
      end
      get '/', to: 'guide#home', defaults: {app: Rails.configuration.lti_default_tool}
    end

    root to: 'guide#home', tenant: 'default', app: Rails.configuration.lti_default_tool

    mount RailsLti2Provider::Engine => '/rails_lti2_provider'
  end
end
