class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.references :order, null: false, foreign_key: true
      t.string :payment_method
      t.string :payment_status
      t.string :transaction_id

      t.timestamps
    end
  end
end
