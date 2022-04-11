module DeviseHelper
  # This is a translation of file "views/devise/shared/_links.html.erb" and its functionality

  def devise_shared_links
    devise_fields = []

    if devise_mapping.rememberable?
      devise_fields.push( {name: "remember_me", type: "checkbox", label: "Remember me"} )
    end

     if controller_name != 'sessions'
       devise_fields.push( {name: "Log in", type: "link", path: new_session_path(resource_name)} )
     end

     if devise_mapping.registerable? && controller_name != 'registrations'
        devise_fields.push( {name: "Sign up", type: "link", path: new_registration_path(resource_name)} )
     end

     if devise_mapping.recoverable? && controller_name != 'passwords' && controller_name != 'registrations'
        devise_fields.push( {name: "Forgot your password?", type: "link", path: new_password_path(resource_name)} )
     end

     if devise_mapping.confirmable? && controller_name != 'confirmations'
        devise_fields.push( {name: "Didn't receive confirmation instructions?", type: "link", path: new_confirmation_path(resource_name)} )
     end

     if devise_mapping.lockable? && resource_class.unlock_strategy_enabled?(:email) && controller_name != 'unlocks'
        devise_fields.push( {name: "Didn't receive unlock instructions?", type: "link", path: new_unlock_path(resource_name)} )
     end

     if devise_mapping.omniauthable?
       resource_class.omniauth_providers.each do |provider|
         devise_fields.push( {name: "Sign in with #{OmniAuth::Utils.camelize(provider)}", type: "link", path: omniauth_authorize_path(resource_name, provider), method: "post"} )
       end
     end


    return devise_fields
  end

end