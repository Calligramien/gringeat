class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.bigint :product_code
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
