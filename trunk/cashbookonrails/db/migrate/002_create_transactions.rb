class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.date :date
      t.string :number
      t.string :payee_category
      t.float :amount
      t.boolean :credit
      t.references :account

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
