require 'digest/md5'

src_dir = '/var/www/htdocs/xyz'
tes = [
 %w{std png},
 %w{pale png},
 %w{blank png},
 %w{english png},
 %w{ort jpg}
]
tes += [["19480000dol", "png"], ["19620000dol", "png"], ["20130717dol", "png"], ["20130717dol2", "png"], ["20130902dol", "png"], ["20130903lsi", "png"], ["20131017dol", "png"], ["20131017dol2", "png"], ["20131204doh", "png"], ["20131204doh2", "png"], ["20131217doh", "png"], ["20131217doh2", "png"], ["20131224lsi", "png"], ["20140216doh", "png"], ["20140216doh2", "png"], ["20140226lsi", "png"], ["20140322dol", "png"], ["20140322dol2", "png"], ["20140330lsi", "png"], ["20140517lsi", "png"], ["20140602lsi", "png"], ["20140704dol", "png"], ["20140704dol2", "png"], ["20140704lsi", "png"], ["20140711dol", "png"], ["20140813dol", "png"], ["20140818-0929d_sar_ontake", "png"], ["20140818d_mag_ontake", "png"], ["20140819dol", "png"], ["20140820dol", "png"], ["20140820dol2", "png"], ["20140820dol3", "png"], ["20140821lsi", "png"], ["20140822_1003d_sar_ontake", "png"], ["20140828dol", "png"], ["20140830dol", "png"], ["20140831dol", "png"], ["20140906lsi", "png"], ["20140927d_vlcd_t_ontake", "png"], ["20140928dol", "png"], ["20140929-1124d_sar_naganohokubu", "png"], ["20140929d_mag_ontake", "png"], ["20140929dol", "png"], ["20140929dol2", "png"], ["20140930-1125d_sar_naganohokubu", "png"], ["20140930dol", "png"], ["20141002-1127d_sar_naganohokubu", "png"], ["20141008lsi", "png"], ["20141014-1125d_sar_naganohokubu", "png"], ["20141204doh", "png"], ["20141210doh", "png"], ["20141210doh2", "png"], ["AFM", "png"], ["CCM1", "png"], ["CCM2", "png"], ["GMLD_glcnmo2", "png"], ["GMLD_ptc2", "png"], ["KIBANCHIZU/10m_kazan", "png"], ["KIBANCHIZU/5m_laser", "png"], ["KIBANCHIZU/5m_syashin", "png"], ["LCM25K", "png"], ["LCM25K_2012", "png"], ["LCMFC01", "png"], ["LCMFC02", "png"], ["LUM200K", "png"], ["LUM4BL/capital1974", "png"], ["LUM4BL/capital1979", "png"], ["LUM4BL/capital1984", "png"], ["LUM4BL/capital1989", "png"], ["LUM4BL/capital1994", "png"], ["LUM4BL/capital2000", "png"], ["LUM4BL/capital2005", "png"], ["LUM4BL/chubu1977", "png"], ["LUM4BL/chubu1982", "png"], ["LUM4BL/chubu1987", "png"], ["LUM4BL/chubu1991", "png"], ["LUM4BL/chubu1997", "png"], ["LUM4BL/chubu2003", "png"], ["LUM4BL/kinki1974", "png"], ["LUM4BL/kinki1979", "png"], ["LUM4BL/kinki1985", "png"], ["LUM4BL/kinki1991", "png"], ["LUM4BL/kinki1996", "png"], ["LUM4BL/kinki2001", "png"], ["LUM4BL/kinki2008", "png"], ["VBM/vbm01meakan", "png"], ["VBM/vbm02tokachi", "png"], ["VBM/vbm03tarumae", "png"], ["VBM/vbm04usu", "png"], ["VBM/vbm05hokkaidokoma", "png"], ["VBM/vbm06iwaki", "png"], ["VBM/vbm07akitayake", "png"], ["VBM/vbm08iwate", "png"], ["VBM/vbm09kurikoma", "png"], ["VBM/vbm10akitakoma", "png"], ["VBM/vbm11chokai", "png"], ["VBM/vbm12zao", "png"], ["VBM/vbm13azuma", "png"], ["VBM/vbm14adatara", "png"], ["VBM/vbm15bandai", "png"], ["VBM/vbm16nasu", "png"], ["VBM/vbm17kusatsushirane", "png"], ["VBM/vbm18asama", "png"], ["VBM/vbm19hakone", "png"], ["VBM/vbm20fuji", "png"], ["VBM/vbm21eastizu", "png"], ["VBM/vbm22izuoshima", "png"], ["VBM/vbm23miyake", "png"], ["VBM/vbm24yakedake", "png"], ["VBM/vbm25ontake", "png"], ["VBM/vbm26tsurumi", "png"], ["VBM/vbm27kujyu", "png"], ["VBM/vbm28aso", "png"], ["VBM/vbm29unzen", "png"], ["VBM/vbm30kirishima", "png"], ["VBM/vbm31sakurajima", "png"], ["VBM/vbm32satsumatakesima", "png"], ["VBM/vbm33satsumaiojima", "png"], ["VBM/vbm34suwanosejima", "png"], ["VBM/vbm35esan", "png"], ["VLCD/00iwatesan", "png"], ["VLCD/00kurikomayama", "png"], ["VLCD/00ontakesan", "png"], ["VLCD/01sakurazima", "png"], ["VLCD/02tokachidake", "png"], ["VLCD/03kusatsushiranesan", "png"], ["VLCD/04asosan", "png"], ["VLCD/05komagatake", "png"], ["VLCD/06miyakezima", "png"], ["VLCD/07unzendake", "png"], ["VLCD/08kirishimayama", "png"], ["VLCD/09usuzan", "png"], ["VLCD/10tarumaesan", "png"], ["VLCD/11bandaisan", "png"], ["VLCD/12fujisan", "png"], ["VLCD/13izuoshima", "png"], ["VLCD/14adatarayama", "png"], ["VLCD/15kujirenzan", "png"], ["VLCD/16akandake", "png"], ["VLCD/17satsumaiojima", "png"], ["VLCD/yakiyama", "png"], ["airphoto", "png"], ["fgd2500_area", "png"], ["fgd_update/2014-10", "png"], ["fukkokizu", "png"], ["gazo1", "jpg"], ["gazo2", "jpg"], ["gazo3", "jpg"], ["gazo4", "jpg"], ["izuoshima/laserortho", "png"], ["izuoshima/vbm2_izuoshima_chocolate", "png"], ["relief", "png"], ["swale", "png"], ["toho1", "jpg"], ["toho2", "jpg"], ["toho3", "jpg"]]

tes.each {|t, e|
 w = File.open("/var/www/htdocs/xyz/#{t}/mokuroku.csv", 'w')
 zs = Dir.entries("#{src_dir}/#{t}").
   sort{|a, b| a.to_i <=> b.to_i}.
   select{|v| v.to_i.to_s == v}
 zs.each {|z|
   xs = Dir.entries("#{src_dir}/#{t}/#{z}").
     sort{|a, b| b.to_i <=> a.to_i}.
     select{|v| v.to_i.to_s == v}
   xs.each {|x|
     ys = Dir.entries("#{src_dir}/#{t}/#{z}/#{x}").
       map{|v| v.split('.')[0]}.
       sort{|a, b| a.to_i <=> b.to_i}.
       select{|v| v.to_i.to_s == v}
     sleep 10 if File.exist?('sleep')
     ys.each {|y|
       path = "#{src_dir}/#{t}/#{z}/#{x}/#{y}.#{e}"
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
 w.close
 system "gzip -9f /var/www/htdocs/xyz/#{t}/mokuroku.csv"
}
