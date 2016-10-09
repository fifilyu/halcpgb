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
    `bundle exec asciidoctor halcpgb.adoc`
    puts " -- HTML output at halcpgb.html"

    puts "Converting to PDF..."
    `bundle exec asciidoctor-pdf -r asciidoctor-pdf-cjk-kai_gen_gothic -a pdf-style=KaiGenGothicCN halcpgb.adoc`
    puts " -- PDF output at halcpgb.pdf"
  end
end
