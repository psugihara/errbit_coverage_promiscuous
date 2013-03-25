class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :message
      t.string :errbit_id

      t.timestamps
    end
  end
end
