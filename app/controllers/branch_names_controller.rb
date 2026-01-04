class BranchNamesController < ApplicationController
  def index
    save_token_if_provided
    @access_token = FizzyConfig.access_token || session[:fizzy_access_token] || params[:access_token]
    @account_slug = params[:account_slug]
    @card_number = params[:card_number]
    @platform = params[:platform] || "dashboard"

    return load_accounts unless @access_token.present?

    return load_cards_list if @account_slug.present? && @card_number.blank?

    return load_single_card if @account_slug.present? && @card_number.present?

    load_accounts
  rescue Fizzy::UnauthorizedError
    @error = "Invalid access token"
    session.delete(:fizzy_access_token)
    load_accounts
  rescue Fizzy::NotFoundError
    @error = "Card not found"
    load_cards_list if @account_slug.present?
  rescue Fizzy::ApiError => e
    @error = "API error: #{e.message}"
  end

  private

  def save_token_if_provided
    session[:fizzy_access_token] = params[:access_token] if params[:access_token].present?
  end

  def load_accounts
    return unless @access_token.present?

    @accounts = fetch_identity["accounts"] || []
  rescue Fizzy::ApiError
    @accounts = []
  end

  def load_cards_list
    @cards = fetch_cards || []
    @cards_with_branches = @cards.map do |card|
      {
        card: card,
        branch_name: BranchName::Generator.new(
          task_name: card["title"],
          task_number: card["number"],
          platform: @platform
        ).generate
      }
    end
  end

  def load_single_card
    @card = fetch_card
    return unless @card

    @branch_name = BranchName::Generator.new(
      task_name: @card["title"],
      task_number: @card["number"],
      platform: @platform
    ).generate
  end

  def fetch_identity
    client = Fizzy::Client.new(access_token: @access_token)
    client.identity
  end

  def fetch_cards
    client = Fizzy::Client.new(access_token: @access_token)
    client.cards(account_slug: @account_slug, sorted_by: "latest")
  end

  def fetch_card
    client = Fizzy::Client.new(access_token: @access_token)
    client.card(account_slug: @account_slug, card_number: @card_number)
  end
end

