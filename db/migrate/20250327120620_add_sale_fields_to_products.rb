class AddSaleFieldsToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :on_sale, :boolean
    add_column :products, :sale_price, :decimal
    add_column :products, :new_arrival, :boolean
  end
end
