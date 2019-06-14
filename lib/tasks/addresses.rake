require 'net/http'
require 'zip'
require 'csv'
require 'nkf'

namespace :addresses do
  desc '住所データを日本郵便のcsvから作る'
  task import_data: :environment do
    url = URI.parse('https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip')
    http = Net::HTTP.new(url.host, 443)
    http.use_ssl = true
    res = http.get(url.path)

    File.open("#{Rails.root}/lib/zipcode/zipcode.zip", 'wb') do |f|
      f.write(res.body)
    end

    ::Zip::File.open("#{Rails.root}/lib/zipcode/zipcode.zip") do |zip|
      entry = zip.glob('KEN_ALL.CSV').first
      content = entry.get_input_stream.read
      CSV.parse(NKF.nkf('-w -Lu', content)) do |row|
        # 同じ郵便番号で町域名が違うことがあるが町域名は扱わないから
        # 郵便番号がすでに存在していたら飛ばす
        next if Address.exists?(zipcode: row[2])

        Address.create(zipcode: row[2], prefecture: row[6], city: row[7])
      end
    end
  end
end
