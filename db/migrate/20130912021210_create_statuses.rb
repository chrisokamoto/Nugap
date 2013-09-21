class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :tipo

      t.timestamps
    end
  end
end
