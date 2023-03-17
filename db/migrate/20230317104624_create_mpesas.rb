class CreateMpesas < ActiveRecord::Migration[6.1]
  def change
    create_table :mpesas do |t|
      t.string :phoneNumber
      t.string :amount
      t.string :checkoutRequestID
      t.string :merchantRequestID
      t.string :MpesaReceiptNumber

      t.timestamps
    end
  end
end
