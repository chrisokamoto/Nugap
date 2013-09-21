class CreateEmbalagems < ActiveRecord::Migration
  def change
    create_table :embalagems do |t|
      t.string :tipo

      t.timestamps
    end
  end
end
