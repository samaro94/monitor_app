class Form::Component < ViewComponent::Base
  def initialize(title:"", resource:"", url:"", fields:{}, submit:{}, cancel:{})
    @title = title
    @resource = resource
    @url = url
    @fields = fields
    @submit = submit
    @cancel = cancel
  end

  # expected input structure for fields param
  # [ {name: "name", type: "text", autocomplete: "autocomplete", label: "label"} ]

end
