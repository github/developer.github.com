require 'nanoc3/tasks'

desc "compile and copy output to ../developer.github.pages"
task :publish => [:clean] do
  sh "nanoc compile"
  sh "cp -r output/ ../developer.github.pages"
end
