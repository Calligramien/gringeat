class AddReferencesToProductViewsTable < ActiveRecord::Migration[6.0]
  def change
    add_reference :product_views, :product, index: true
  end
end
