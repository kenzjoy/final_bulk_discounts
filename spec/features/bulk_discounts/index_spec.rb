require 'rails_helper'

RSpec.describe "merchants bulk index page", type: :feature do
  before :each do
    @crystal_moon = Merchant.create!(name: "Crystal Moon Designs")
    @surf_designs = Merchant.create!(name: "Surf & Co. Designs")

    @bulk_discount_a = BulkDiscount.create!(merchant_id: @crystal_moon.id, percentage_discount: 20, quantity_threshold: 10)
    @bulk_discount_b = BulkDiscount.create!(merchant_id: @crystal_moon.id, percentage_discount: 15, quantity_threshold: 5)
    @bulk_discount_c = BulkDiscount.create!(merchant_id: @surf_designs.id, percentage_discount: 30, quantity_threshold: 20)

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
  end

  it 'shows all of my bulk discounts including their percentage discount and quantity threashold.' do
    visit merchant_bulk_discounts_path(@crystal_moon)

    expect(page).to have_content("Save 20% when you purchase 10 of the same item.")
    expect(page).to have_content("Save 15% when you purchase 5 of the same item.")
  end

  it 'each bulk discount listed includes a link to its show page' do
    visit merchant_bulk_discounts_path(@crystal_moon)

    expect(page).to have_css("#merchant-discount#{@bulk_discount_a.id}")
    expect(page).to have_css("#merchant-discount#{@bulk_discount_b.id}")
    expect(page).to_not have_css("#merchant-discount#{@bulk_discount_c.id}")
    
    within "#merchant-discount#{@bulk_discount_a.id}" do
      expect(page).to have_link("Learn more about this offer!", :href => merchant_bulk_discount_path(@crystal_moon, @bulk_discount_a))
    end

    within "#merchant-discount#{@bulk_discount_b.id}" do
      expect(page).to have_link("Learn more about this offer!", :href => merchant_bulk_discount_path(@crystal_moon, @bulk_discount_b))
    end
  end

  it 'shows a link to create a new discount' do
    visit merchant_bulk_discounts_path(@surf_designs)

    expect(page).to have_css("#new-bulk-discount")

    within "#new-bulk-discount" do
      expect(page).to have_link("Create A New Bulk Discount", :href => new_merchant_bulk_discount_path(@surf_designs))
    end
  end

  it 'each bulk discount has a link to delete that discount. when the merchant
  clicks this link, it redirects back to the bulk discount index page and that
  discount is not longer listed' do
    visit merchant_bulk_discounts_path(@crystal_moon)

    within "#merchant-discount#{@bulk_discount_a.id}" do
      expect(page).to have_link("Delete This Offer")
    end

    within "#merchant-discount#{@bulk_discount_b.id}" do
      expect(page).to have_link("Delete This Offer")
    end

    within "#merchant-discount#{@bulk_discount_b.id}" do
      click_link "Delete This Offer"
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@crystal_moon))
    expect(page).to_not have_css("#merchant-discount#{@bulk_discount_b.id}")
    expect(page).to have_css("#merchant-discount#{@bulk_discount_a.id}")
    
    within "#merchant-discount#{@bulk_discount_a.id}" do
      click_link "Delete This Offer"
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@crystal_moon))
    expect(page).to_not have_css("#merchant-discount#{@bulk_discount_a.id}")
  end
end

