def app_name(path)
  File.basename(path).
    sub(/\.rb$/, "")
end

# Initialize
puts <<EOS
Install script path?
(e.g. foo/bar.rb)
EOS

# Mainloop
loop do
  args = prompt.split

  opts = {}
  
  args.each do |path|
    unless File.exist? path
      puts "Not found at '#{Dir.pwd}'."
      next
    end
    
    app_name = app_name(path)
    app_path = File.join(Dir.documents, ".app", app_name)
    
    if File.exist? app_path
      puts "Already exist #{app_path}"
      next
    end
  
    File.open(app_path, "w") do |f|
      relative_path = File.expand_path(path).sub(/^#{Dir.documents}\//, "")
      f.write "require '#{relative_path}'"
      puts "Install .app/#{app_name}"
    end
  end
end
