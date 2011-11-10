namespace :import_cards do 
  
  desc "Import RX Cards"
  task :load_cards => :environment do
    require 'csv'
    
    months = ['Jan','Feb','Mar', 'Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
    
    Card.destroy_all
    Lot.destroy_all
    
    upload = File.join(Rails.root.to_s, 'lib', 'data','rxcards_5k.csv')
    logcount = 0
    lots = {}
    CSV.foreach(upload, :headers => true) do |row|
      
      d,m = row[1].split('-')
     
      i = months.index(m) + 1
      thedate = Date.new(2011,i,d.to_i)
      Card.create(:number => row[0],
                  :exp_date => thedate,
                  :lot_id => row[2])
                  
      if lots.include?(row[2])
        lots[row[2]] += 1
      else
        lots[row[2]] = 1
      end
      
      logcount += 1
    end
    puts "Created #{logcount} card entries."
    
    logcount = 0
    
    lots.each do |n,q|
      Lot.create(:number => n,
                  :quantity => q)
      logcount += 1
    end
    
    puts "Create #{logcount} unique lot entries."
  end
end