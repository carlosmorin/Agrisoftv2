namespace :sat_catalogs do
  desc "Importing and saving SAT catalog"

  task import_products_and_services: :environment do
    puts 'Reding xls file...'
    puts 'Reding done'
    file_path = 'https://pubilcbucket.s3.us-west-1.amazonaws.com/catCFDI_15012020.xlsx'
    xlsx = Roo::Spreadsheet.open(file_path)
    sheet = xlsx.sheet('c_ClaveProdServ')

    SatProduct.transaction do
      puts 'Saving products...'
      sheet.parse(headers: true, clean: true).each.with_index do |row, i|
        next if i < 4

        sp = SatProduct.new( key: row['Key'].to_s, name: row['Name'] )
        if sp.save!
          print '.'
        else
          puts sp.errors.full_messages.to_sentence
          puts sp
          puts '------------------------------------'
        end
      end
    end
    puts 'Saving products finish'
  end

  task import_unit_measure: :environment do
    puts 'Reding xls file...'
    puts 'Reding done'
    file_path = 'https://pubilcbucket.s3.us-west-1.amazonaws.com/catCFDI_15012020.xlsx'
    xlsx = Roo::Spreadsheet.open(file_path)
    sheet = xlsx.sheet('c_ClaveUnidad')

    SatUnitMeasure.transaction do
      puts 'Saving units...'
      sheet.parse(headers: true, clean: true).each.with_index do |row, i|
        next if i < 4

        sum = SatUnitMeasure.new( key: row['Key'].to_s, name: row['Name'] )
        if sum.save!
          print '.'
        else
          puts sum.errors.full_messages.to_sentence
          puts sum
          puts '------------------------------------'
        end
      end
    end
    puts 'Saving units finish'
  end
end
