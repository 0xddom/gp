require 'rake'

task :plot do
  reports = Rake::FileList[ENV['pattern']]

  puts 'unset key'
  puts 'set xlabel "Generations"'
  puts 'set ylabel "Adjusted fitness"'
  print "plot "
  puts reports.map {|f| "\"#{f}\" with lines"}.join ','
end
