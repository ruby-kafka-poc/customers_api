# frozen_string_literal: true

class CreateOrganizationAssociations < ActiveRecord::Migration[7.0]
  def change
    create_table :organization_associations do |t|
      t.belongs_to :organization, foreign_key: true
      t.belongs_to :customer, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
