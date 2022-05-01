# frozen_string_literal: true

Rails.application.routes.draw do
  resources :organizations do
    resources :organization_associations, path: :invites, only: %i[create destroy index]
  end
  resources :customers
end
