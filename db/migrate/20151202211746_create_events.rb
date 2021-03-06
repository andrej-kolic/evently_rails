class CreateEvents < ActiveRecord::Migration
  def change

    create_table :events do |t|
      t.string :title, null:false
      t.string :description
      t.string :location
      t.datetime :start_time

      t.belongs_to :user, index:true, null:false

      t.timestamps null: false
    end


    create_table :users do |t|
      t.string :username, null:false
      t.string :password
      t.text :notes
      t.boolean :admin
      t.string :authentication_token

      t.timestamps null: false
    end

  end
end
