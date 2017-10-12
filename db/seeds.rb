# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Rake::Task['seed:users'].invoke
Rake::Task['seed:posts'].invoke
Rake::Task['seed:photos'].invoke
Rake::Task['seed:comments'].invoke
Rake::Task['seed:likes'].invoke
