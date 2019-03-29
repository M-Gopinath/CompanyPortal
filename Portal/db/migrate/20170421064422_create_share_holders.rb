class CreateShareHolders < ActiveRecord::Migration[5.0]
  def change
    create_table :share_holders do |t|
      t.string :name
      t.decimal :percentage, precision: 10, scale: 2

      t.timestamps
    end
  end
end
