class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :message

      t.timestamps
    end
  end
end
