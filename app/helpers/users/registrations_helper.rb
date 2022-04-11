module Users::RegistrationsHelper
  include DeviseHelper

  def registration_fields
    fields = [
        {name: "name", type: "text", label: "Name"},
        {name: "lastname", type: "text", label: "Lastname"},
        {name: "email", type: "email", autocomplete: "email", label: "Email"},
        {name: "password", type: "password", autocomplete: "current-password", label: "Password"},
        {name: "password_confirmation", type: "password", autocomplete: "new-password", label: "Password confirmation"}
    ]

    fields += devise_shared_links

    return fields
  end

end
