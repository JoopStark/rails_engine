def load_test_data
  @merchant_1 = Merchant.create(name: "Shizuka Hattori" )
    @item_1_1 = @merchant_1.items.create(name: "Portable Bento Box Fax", description: "I give up. I see no point in living if I can’t be beautiful.", unit_price: 9 )
    @item_1_2 = @merchant_1.items.create(name: "Criminal Tracking Glasses", description: "Why does everything that's good for you have to taste so bad?", unit_price: 8 )
    @item_1_3 = @merchant_1.items.create(name: "Kamen Yaiba Voice Changer/Pen Voice Changer", description: "Hahaha... This isn't a Western, you can't hit me from here.", unit_price: 7 )
    
  @merchant_2 = Merchant.create(name: "Chikage Kuroba" )
    @item_2_1 = @merchant_1.items.create(name: "Turbo Engine Skateboard", description: "Aren't you even going to knock? You're the most patheic little girl I've ever seen!", unit_price: 6.1 )
    @item_2_2 = @merchant_1.items.create(name: "Hang Glider Cape", description: "Look, everyone! This is what hatred looks like! This is what it does when it catches hold of you! It's eating me alive, and very soon now it will kill me! Fear and anger only make it grow faster!", unit_price: 6 )
    @item_2_3 = @merchant_1.items.create(name: "Voice-Changing Choker", description: "A girl just fell from the sky, boss!", unit_price: 5.5 )
    
  @merchant_3 = Merchant.create(name: "Subaru Okiya" )
    @item_3_1 = @merchant_1.items.create(name: "Portable Bento Box Fax", description: "We each need to find our own inspiration, Kiki. Sometimes it’s not easy.", unit_price: 5.0 )
    @item_3_2 = @merchant_1.items.create(name: "Portable Bento Box Fax", description: "I give up. I see no point in living if I can’t be beautiful.", unit_price: 1.5 )
    @item_3_3 = @merchant_1.items.create(name: "Portable Bento Box Fax", description: "I give up. I see no point in living if I can’t be beautiful.", unit_price: 1.5 )
    
  @merchant_4 = Merchant.create(name: "Azusa Enomoto" )
    @item_4_1 = @merchant_1.items.create(name: "Portable Bento Box Fax", description: "I give up. I see no point in living if I can’t be beautiful.", unit_price: 1.5 )
    @item_4_2 = @merchant_1.items.create(name: "Portable Bento Box Fax", description: "I give up. I see no point in living if I can’t be beautiful.", unit_price: 1.5 )
    @item_4_3 = @merchant_1.items.create(name: "Portable Bento Box Fax", description: "I give up. I see no point in living if I can’t be beautiful.", unit_price: 1.5 )



end