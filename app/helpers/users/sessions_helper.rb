module Users::SessionsHelper
  include DeviseHelper

  def login_fields
    fields = [
        {name: "email", type: "email", autocomplete: "email", label: I18n.t('email')},
        {name: "password", type: "password", autocomplete: "current-password", label: I18n.t('devise.password')}
    ]

    fields += devise_shared_links

    return fields
  end

end
