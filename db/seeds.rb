# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create!(
    [
        {
            id: 1,
            username: 'admin',
            password: 'admin',
            admin: true
        },
        {
            id: 2,
            username: 'andrej',
            password: 'trodon',
            admin: false
        },
        {
            id: 3,
            username: 'guest',
            password: 'guest',
            admin: nil
        }
    ]
)


events = Event.create!(
    [
        {
            title: 'e 1_1',
            start_time: '01:01:01',
            user: users.first
        },
        {
            title: 'e 1_2',
            start_time: '01:01:01',
            user: users.first
        },

        {
            title: 'e 2_1',
            start_time: '01:01:01',
            user: users[1]
        },
        {
            title: 'e 2_2',
            start_time: '01:01:01',
            user: users[1]
        },
        {
            title: 'e 2_3',
            start_time: '01:01:01',
            user: users[1]
        }

    ]
)