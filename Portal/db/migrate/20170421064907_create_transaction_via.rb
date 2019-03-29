class CreateTransactionVia < ActiveRecord::Migration[5.0]
  def change
    create_table :transaction_via do |t|
      t.string :name

      t.timestamps
    end
  end
end
