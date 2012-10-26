class CreateReproductionSimbols < ActiveRecord::Migration
  def change
    create_table :reproduction_simbols do |t|
      t.string :simbol
      t.string :meaning

      t.timestamps
    end
  end
end
