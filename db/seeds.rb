# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AUTHOR = {
  first_name: 'Herman',
  last_name: 'Melville',
  website: 'http://melville.org',
  genres: ['Tall tale', 'Allegory'],
  description: 'Whaaaaaaales'
}.freeze

BOOKS = [
  {
    title: 'Moby Dick',
    description: 'Wuby on Whales',
    publish_date: Time.zone.local(1851, 10, 18),
    rating: 5
  },
  {
    title: 'Bartleby the Scrivener',
    description: 'The 343rd greatest fiction book of all time',
    publish_date: Time.zone.local(1856, 11, 20),
    rating: 3
  },
  {
    title: 'Typee: A Peep at Polynesian Life',
    description: 'His first foray into whaaaaaaales',
    publish_date: Time.zone.local(1846, 0o1, 0o1),
    rating: 4
  }
].freeze

USERS = [
  {
    first_name: 'John',
    last_name: 'Smith',
    email: 'test@example.com',
    password: 'NotSupposedToBeProduction123',
    password_confirmation: 'NotSupposedToBeProduction123'
  },
  {
    first_name: 'Herman',
    last_name: 'Melville',
    email: 'hm@melville.org',
    password: 'theyrenotallaboutwhales!!',
    password_confirmation: 'theyrenotallaboutwhales!!'
  }
].freeze

author = Author.create(AUTHOR)
author.books.create(BOOKS)

User.create(USERS)
