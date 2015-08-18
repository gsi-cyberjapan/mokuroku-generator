require 'digest/md5'
require 'open-uri'
require 'json'

DRY_RUN = false
APPENDING = false

$src_dir = '/var/www/htdocs/xyz'
$tes = []

def process(entry, stack)
  case entry['type']
  when 'LayerGroup'
    stack.push(entry['title'])
    entry['entries'].each {|child|
      process(child, stack)
    }
    stack.pop
  when 'Layer'
    stack.push(entry['title'])
    r = entry['url'].split('/{z}/{x}/{y}.')
    if r.size == 2
      $tes << [r[0].split('/xyz/')[-1], r[1]]
    end
    stack.pop
  end
end

[0, 1, 2, 3, 4, '_experimental'].each {|e|
  url = "http://gsi-cyberjapan.github.io/gsimaps/layers_txt/layers#{e}.txt"
  JSON.parse(open(url).read)['layers'].each {|entry|
    process(entry, [])
  }
}

$tes.uniq!
$tes.each {|t, e|
  dst_path = "/var/www/htdocs/xyz/#{t}/mokuroku.csv"
  next if File.exist?(dst_path + ".gz") if APPENDING
  print "Creating #{dst_path}\n" if DRY_RUN
  w = DRY_RUN ? $stdout : File.open(dst_path, 'w')
  zs = Dir.entries("#{$src_dir}/#{t}").
    sort{|a, b| a.to_i <=> b.to_i}.
    select{|v| v.to_i.to_s == v}
  zs.each {|z|
    xs = Dir.entries("#{$src_dir}/#{t}/#{z}").
      sort{|a, b| b.to_i <=> a.to_i}.
      select{|v| v.to_i.to_s == v}
    xs.each {|x|
      ys = Dir.entries("#{$src_dir}/#{t}/#{z}/#{x}").
        map{|v| v.split('.')[0]}.
        sort{|a, b| a.to_i <=> b.to_i}.
        select{|v| v.to_i.to_s == v}.uniq
      sleep 10 if File.exist?('sleep')
      ys.each {|y|
        path = "#{$src_dir}/#{t}/#{z}/#{x}/#{y}.#{e}"
#       print ["#{z}/#{x}/#{y}", "#{t}/#{z}/#{x}/#{y}.#{e}"].join("\t"), "\n"
        begin
          w.print ["#{z}/#{x}/#{y}.#{e}",
            File.mtime(path).to_i, File.size(path),
            Digest::MD5.file(path)].join(','), "\n"
        rescue
          # file not found, maybe deleted.
        end
      }
    }
  }
  w.close unless DRY_RUN
  system "gzip -9f /var/www/htdocs/xyz/#{t}/mokuroku.csv" unless DRY_RUN
}
