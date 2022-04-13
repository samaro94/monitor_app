module ServicesHelper
    def services_fields(service)
        fields = [
            {name: "name", type: "text", label: I18n.t('name'), value: service.name},
            {name: "details", type: "text", label: I18n.t('details'), value: service.details}
        ]

        return fields
    end
end
