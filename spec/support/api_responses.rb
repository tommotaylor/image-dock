RSpec::Matchers.define :be_api_json_response do |_|
  match do |actual|
    actual.content_type == "application/vnd.api+json" || "application/json"
  end

  failure_message do |actual|
    %(response content type "#{actual.content_type}" is not a valid json response)
  end
end
