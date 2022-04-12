module ServicesHelper
    def services_fields
        fields = [
            {name: "name", type: "text", label: I18n.t('name')},
            {name: "details", type: "text", label: I18n.t('details')}
        ]

        return fields
    end
end
