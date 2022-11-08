require 'rails_helper'

RSpec.feature "Admin Merchant Edit Page", type: :feature do
  before :each do
    @crystal_moon = Merchant.create!(name: "Crystal Moon Designs")
    @surf_designs = Merchant.create!(name: "Surf & Co. Designs")
    @merchant_3 = Merchant.create!(name: "Outer Outfitters")

    @pearl = @crystal_moon.items.create!(name: "Pearl", description: "Not a BlackPearl!", unit_price: 25)
    @moon_rock = @crystal_moon.items.create!(name: "Moon Rock", description: "Evolve Your Pokemon!", unit_price: 105)
    @lapis_lazuli = @crystal_moon.items.create!(name: "Lapis Lazuli", description: "Not the Jewel Knight!", unit_price: 45)
    @topaz = @crystal_moon.items.create!(name: "Topaz", description: "Just Another Topaz!", unit_price: 55)
    @amethyst = @crystal_moon.items.create!(name: "Amethyst", description: "Common Loot!", unit_price: 55)
    @emerald = @crystal_moon.items.create!(name: "Emerald", description: "Where's Sonic?", unit_price: 85)
    @ruby = @crystal_moon.items.create!(name: "Ruby", description: "Razzle Dazzle?", unit_price: 65)
    @sapphire = @crystal_moon.items.create!(name: "Sapphire", description: "Deep Blue!", unit_price: 45)
    @dream_catcher = @crystal_moon.items.create!(name: "Midnight Dream Catcher", description: "Catch the magic of your dreams!", unit_price: 25)
    @rose_quartz = @crystal_moon.items.create!(name: "Rose Quartz Pendant", description: "Manifest the love of your life!", unit_price: 37)
    @tarot_deck = @crystal_moon.items.create!(name: "Witchy Tarot Deck", description: "Unveil your true path!", unit_price: 22)
    @wax = @surf_designs.items.create!(name: "Board Wax", description: "Hang ten!", unit_price: 7)
    @rash_guard = @surf_designs.items.create!(name: "Radical Rash Guard", description: "Stay totally groovy and rash free!", unit_price: 50)
    @zinc = @surf_designs.items.create!(name: "100% Zinc Face Protectant", description: "Our original organic formula!", unit_price: 13)
    @surf_board = @surf_designs.items.create!(name: "Surf Board", description: "Our original 12' board!", unit_price: 200)

    @paul = Customer.create!(first_name: "Paul", last_name: "Walker")
    @sam = Customer.create!(first_name: "Sam", last_name: "Gamgee")
    @abbas = Customer.create!(first_name: "Abbas", last_name: "Firnas")
    @hamada = Customer.create!(first_name: "Hamada", last_name: "Hilal")
    @frodo = Customer.create!(first_name: "Frodo", last_name: "Baggins")
    @eevee = Customer.create!(first_name: "Eevee", last_name: "Ketchup")

    @invoice_1 = Invoice.create!(status: 2, customer_id: @paul.id)
    @invoice_2 = Invoice.create!(status: 2, customer_id: @paul.id)
    @invoice_3 = Invoice.create!(status: 2, customer_id: @sam.id)
    @invoice_4 = Invoice.create!(status: 2, customer_id: @sam.id)
    @invoice_5 = Invoice.create!(status: 2, customer_id: @abbas.id)
    @invoice_6 = Invoice.create!(status: 2, customer_id: @abbas.id)
    @invoice_7 = Invoice.create!(status: 2, customer_id: @hamada.id)
    @invoice_8 = Invoice.create!(status: 2, customer_id: @hamada.id)
    @invoice_9 = Invoice.create!(status: 2, customer_id: @frodo.id)
    @invoice_10 = Invoice.create!(status: 2, customer_id: @frodo.id)
    @invoice_11 = Invoice.create!(status: 2, customer_id: @eevee.id)
    @invoice_12 = Invoice.create!(status: 2, customer_id: @paul.id)
    @invoice_13 = Invoice.create!(status: 2, customer_id: @sam.id)
    @invoice_14 = Invoice.create!(status: 2, customer_id: @eevee.id)
    @invoice_15 = Invoice.create!(status: 0, customer_id: @eevee.id)
    @invoice_16 = Invoice.create!(status: 2, customer_id: @eevee.id)
    @invoice_17 = Invoice.create!(status: 2, customer_id: @eevee.id)
    @invoice_18 = Invoice.create!(status: 0, customer_id: @paul.id)
    @invoice_19 = Invoice.create!(status: 2, customer_id: @abbas.id)
    @invoice_20 = Invoice.create!(status: 2, customer_id: @frodo.id)
    @invoice_21 = Invoice.create!(status: 2, customer_id: @paul.id)
    @invoice_22 = Invoice.create!(status: 2, customer_id: @eevee.id)

    @pearl_invoice = InvoiceItem.create!(item_id: @pearl.id, invoice_id: @invoice_1.id, quantity: 2, unit_price: 25, status: 1)
    @moon_rock_invoice = InvoiceItem.create!(item_id: @moon_rock.id, invoice_id: @invoice_2.id, quantity: 2, unit_price: 105, status: 1)
    @lapis_lazuli_invoice = InvoiceItem.create!(item_id: @lapis_lazuli.id, invoice_id: @invoice_3.id, quantity: 2, unit_price: 45, status: 1)
    @topaz_invoice = InvoiceItem.create!(item_id: @topaz.id, invoice_id: @invoice_4.id, quantity: 2, unit_price: 55, status: 1)
    @amethyst_invoice = InvoiceItem.create!(item_id: @amethyst.id, invoice_id: @invoice_5.id, quantity: 2, unit_price: 55, status: 2)
    @emerald_invoice = InvoiceItem.create!(item_id: @emerald.id, invoice_id: @invoice_6.id, quantity: 2, unit_price: 85, status: 2)
    @ruby_invoice = InvoiceItem.create!(item_id: @ruby.id, invoice_id: @invoice_7.id, quantity: 2, unit_price: 65, status: 2)
    @sapphire_invoice = InvoiceItem.create!(item_id: @sapphire.id, invoice_id: @invoice_8.id, quantity: 2, unit_price: 45, status: 2)
    @dream_catcher_invoice = InvoiceItem.create!(item_id: @dream_catcher.id, invoice_id: @invoice_9.id, quantity: 2, unit_price: 25, status: 2)
    @rose_quartz_invoice = InvoiceItem.create!(item_id: @rose_quartz.id, invoice_id: @invoice_10.id, quantity: 2, unit_price: 37, status: 2)
    @tarot_deck_invoice = InvoiceItem.create!(item_id: @tarot_deck.id, invoice_id: @invoice_11.id, quantity: 2, unit_price: 22, status: 2)
    @wax_invoice = InvoiceItem.create!(item_id: @wax.id, invoice_id: @invoice_12.id, quantity: 2, unit_price: 7, status: 2)
    @rash_guard_invoice = InvoiceItem.create!(item_id: @rash_guard.id, invoice_id: @invoice_13.id, quantity: 2, unit_price: 50, status: 2)
    @zinc_invoice = InvoiceItem.create!(item_id: @zinc.id, invoice_id: @invoice_14.id, quantity: 2, unit_price: 13, status: 1)
    @surf_board_invoice = InvoiceItem.create!(item_id: @surf_board.id, invoice_id: @invoice_6.id, quantity: 2, unit_price: 200, status: 1)

    @transaction_1 = Transaction.create!(result: 1, invoice_id: @invoice_1.id, credit_card_number: 0001)
    @transaction_2 = Transaction.create!(result: 1, invoice_id: @invoice_2.id, credit_card_number: 0002)
    @transaction_3 = Transaction.create!(result: 1, invoice_id: @invoice_3.id, credit_card_number: 0003)
    @transaction_4 = Transaction.create!(result: 1, invoice_id: @invoice_4.id, credit_card_number: 0004)
    @transaction_5 = Transaction.create!(result: 1, invoice_id: @invoice_5.id, credit_card_number: 0005)
    @transaction_6 = Transaction.create!(result: 1, invoice_id: @invoice_6.id, credit_card_number: 0006)
    @transaction_7 = Transaction.create!(result: 1, invoice_id: @invoice_7.id, credit_card_number: 0007)
    @transaction_8 = Transaction.create!(result: 1, invoice_id: @invoice_8.id, credit_card_number: 0010)
    @transaction_9 = Transaction.create!(result: 1, invoice_id: @invoice_9.id, credit_card_number: 0011)
    @transaction_10 = Transaction.create!(result: 1, invoice_id: @invoice_10.id, credit_card_number: 0012)
    @transaction_11 = Transaction.create!(result: 1, invoice_id: @invoice_11.id, credit_card_number: 0013)
    @transaction_12 = Transaction.create!(result: 1, invoice_id: @invoice_12.id, credit_card_number: 0014)
    @transaction_13 = Transaction.create!(result: 1, invoice_id: @invoice_13.id, credit_card_number: 0015)
    @transaction_14 = Transaction.create!(result: 1, invoice_id: @invoice_14.id, credit_card_number: 0016)
    @transaction_15 = Transaction.create!(result: 1, invoice_id: @invoice_15.id, credit_card_number: 0016)
    @transaction_16 = Transaction.create!(result: 1, invoice_id: @invoice_16.id, credit_card_number: 0016)
    @transaction_17 = Transaction.create!(result: 1, invoice_id: @invoice_17.id, credit_card_number: 0016)
    @transaction_18 = Transaction.create!(result: 1, invoice_id: @invoice_18.id, credit_card_number: 0016)
    @transaction_19 = Transaction.create!(result: 1, invoice_id: @invoice_19.id, credit_card_number: 0016)
    @transaction_20 = Transaction.create!(result: 1, invoice_id: @invoice_20.id, credit_card_number: 0016)
    @transaction_21 = Transaction.create!(result: 0, invoice_id: @invoice_21.id, credit_card_number: 0016)
    @transaction_22 = Transaction.create!(result: 0, invoice_id: @invoice_17.id, credit_card_number: 0016)
  end
  describe 'when accessing the page' do
    it 'has a link in the admin merchant show page that redirects to the edit page for that merchant' do
      visit admin_merchant_path(@crystal_moon)
      click_link 'Update merchant'

      expect(page).to have_current_path(edit_admin_merchant_path(@crystal_moon))
    end
  end
  describe 'when visiting the page' do
    it 'has form fields prefilled with the existing merchant attributes' do
      visit edit_admin_merchant_path(@crystal_moon)

      expect(page).to have_field('Name:', with: 'Crystal Moon Designs')
    end
    it 'redirects to the admin merchant show page with the updated information when the form is filled and submitted' do
      visit edit_admin_merchant_path(@crystal_moon)

      fill_in 'Name:', with: 'Lunar Lake Jewellers'
      click_button 'Update'

      expect(page).to have_current_path(admin_merchant_path(@crystal_moon))
      expect(page).not_to have_content('Crystal Moon Designs')
      expect(page).to have_content('Lunar Lake Jewellers')
    end
    it 'displays a flash message stating the update is successful when the merchant is successfully updated' do
      visit edit_admin_merchant_path(@crystal_moon)

      fill_in 'Name:', with: 'Lunar Lake Jewellers'
      click_button 'Update'

      expect(page).to have_current_path(admin_merchant_path(@crystal_moon))
      expect(page).to have_content('Merchant updated successfully!')
    end
    it 'goes back to the edit page with a flash message when the merchant is not successfully updated' do
      visit edit_admin_merchant_path(@crystal_moon)

      fill_in 'Name:', with: 'This is an very long string that exceeds fifty characters in length'
      click_button 'Update'

      expect(page).to have_current_path(edit_merchant_item_path(@merchant, @item))
      expect(page).to have_content('Error:')

      visit admin_merchant_path(@crystal_moon)
     
      expect(page).not_to have_content('This is an very long string that exceeds fifty characters in length')
      expect(page).to have_content('Crystal Moon Designs')
    end
  end
end
