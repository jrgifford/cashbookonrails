class CreateBills < ActiveRecord::Migration
  def self.up
    create_table :bills do |t|
      t.references :payee
      t.references :account
      t.string :number
      t.date :next_payment_date
      t.string :payment_method
      t.string :frequency
      t.float :amount
      t.references :category

      t.timestamps
    end
  end

  def self.down
    drop_table :bills
  end
end
