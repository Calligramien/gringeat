class CreateProductView < ActiveRecord::Migration[6.0]
  def change
    create_table :product_views do |t|
      t.integer :code
      t.integer :views_quantity

      t.timestamps
    end
  end
end
