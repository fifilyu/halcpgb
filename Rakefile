namespace :book do
  desc 'prepare build'
  task :prebuild do
    Dir.mkdir 'image' unless Dir.exists? 'image'
    Dir.glob("book/*/image/*").each do |image|
      FileUtils.copy(image, "image/" + File.basename(image))
    end
  end

  desc 'prepare build'
  task :prebuild do
    Dir.mkdir 'file' unless Dir.exists? 'file'
    Dir.glob("book/*/file/*").each do |file|
      FileUtils.copy(file, "file/" + File.basename(file))
    end
  end

  desc 'build basic book formats'
  task :build => :prebuild do
    puts "Converting to HTML..."
    `bundle exec asciidoctor -n -a stylesheet=./stylesheets/asciidoctor.css -a index,toc=left,syntaxhighlighting halcpgb.adoc`
    puts " -- HTML output at halcpgb.html"
  end
end
