class Fizzy::Client
  private attr_reader :access_token

  def initialize(access_token:)
    @access_token = access_token
  end

  def identity
    get("/my/identity")
  end

  def cards(account_slug:, **params)
    account_slug = normalize_slug(account_slug)
    get("#{account_slug}/cards", query: params)
  end

  def card(account_slug:, card_number:)
    account_slug = normalize_slug(account_slug)
    get("#{account_slug}/cards/#{card_number}")
  end

  private

  def normalize_slug(slug)
    slug.start_with?("/") ? slug : "/#{slug}"
  end

  def get(path, **options)
    base_url = FizzyConfig.api_base_url || "https://app.fizzy.do"
    response = HTTParty.get(
      "#{base_url}#{path}.json",
      headers: headers,
      **options
    )

    handle_response(response)
  end

  def headers
    {
      "Authorization" => "Bearer #{access_token}",
      "Accept" => "application/json"
    }
  end

  def handle_response(response)
    case response.code
    when 200, 201
      response.parsed_response
    when 401
      raise Fizzy::UnauthorizedError, "Invalid access token"
    when 404
      raise Fizzy::NotFoundError, "Resource not found"
    else
      raise Fizzy::ApiError, "API error: #{response.code}"
    end
  end
end

