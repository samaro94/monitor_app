module Users::SessionsHelper
  include DeviseHelper

  def login_fields
    fields = [
        {name: "email", type: "email", autocomplete: "email", label: "Email"},
        {name: "password", type: "password", autocomplete: "current-password", label: "Password"}
    ]

    fields += devise_shared_links

    return fields
  end

end
