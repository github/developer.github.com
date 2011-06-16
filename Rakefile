require 'nanoc3/tasks'

task :publish => [:clean] do
  sh "nanoc compile"
  sh "cp -r output/ ../developer.github.pages"
end
