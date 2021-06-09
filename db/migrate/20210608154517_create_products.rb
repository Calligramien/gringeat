class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.integer :code
      t.string :name
      t.text :description
      t.string :origin
      t.string :category

      t.timestamps
    end
  end
end
