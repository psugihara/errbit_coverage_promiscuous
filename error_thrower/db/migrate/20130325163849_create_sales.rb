class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|

      t.timestamps
    end
  end
end
