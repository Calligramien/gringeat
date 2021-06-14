class CreateProductViews < ActiveRecord::Migration[6.0]
  def change
    create_table :product_views do |t|
      t.integer :views_quantity
      t.string :code
    end
  end
end
