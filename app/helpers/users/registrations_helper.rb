module Users::RegistrationsHelper
  include DeviseHelper

  def registration_fields
    fields = [
        {name: "name", type: "text", label: I18n.t('name')},
        {name: "lastname", type: "text", label: I18n.t('lastname')},
        {name: "email", type: "email", autocomplete: "email", label: I18n.t('email')},
        {name: "password", type: "password", autocomplete: "current-password", label: I18n.t('devise.password')},
        {name: "password_confirmation", type: "password", autocomplete: "new-password", label: I18n.t('devise.password_confirmation')}
    ]

    fields += devise_shared_links

    return fields
  end

end
