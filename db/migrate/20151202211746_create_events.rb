class CreateEvents < ActiveRecord::Migration
  def change

    create_table :events do |t|
      t.string :title, null:false
      t.string :description
      t.string :location
      t.datetime :start_time

      t.belongs_to :user, index:true

      t.timestamps null: false
    end


    create_table :users do |t|
      t.string :username, null:false
      t.string :password, null:false
      t.text :notes
      t.boolean :admin

      t.timestamps null: false
    end

  end
end
