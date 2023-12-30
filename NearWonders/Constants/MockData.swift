//
//  MockData.swift
//  NearWonders
//
//  Created by Jay Thakur on 18/12/23.
//

import Foundation

/// Acitvity
let trekkingActivity = Activity(
    name: "Trekking",
    icon: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAACXBIWXMAAAsTAAALEwEAmpwYAAACsklEQVR4nO2YXYgOYRTHf7torbC5WFax3GiTLSkfiVBKSlpX7J3yytW6kNbtKqUVLuyV7I3UJoq44UpyIwllqcUFyjeblbX5Wu/q1H/qNM1+vK95Z2c0v5pm5jkzz3POzPOcc54DOTk5OTnRVPEfsA1oJeNMA54Az4CpZJiDwIiOPWSUucCAM+QlUEMGOSMDrgEPdd1GxlgBDAM/gSagRYa8BWaQIW5J8eOu7Y7a2skIrVL4A1Dn2reovR+YTcqp1aI2hQsR8puSdZByDkvRB0B1hHyd5INAPSllAfANKAIbxnjuuozpJKWcl4J29tRrygWslLFDQAMpY71TbqFrXwo8l8ea59ovyeguUkQ1cF+KvQOWqX1zKLK/cLKC2n4AjaSEvVKqqPMX4BjwS/f29W+PIrOjmxRQp3hhCu0GLjoFgwVdrTVyISQzA37rWJKk0puUCHpOSimL5MEG6qi+uP0pT5SsW+/3kBC2l3gKPHLGNCmXGlZu5Rlr3jeGrm2d/AGaSYB9bkr0AfOV1dr96X/su0v9XKbC2Px+5fInO7/WeSBiupVKg9x2UTGmYrRL6XtSutf9nQMxjWGebERRv2JeqV+DWPYaROpeTTHbk8fBHBdzNlIBjqhzy1o9ZszamMfqCHnA2DBlv6rzuJWOYibwMfT3YyHwJldIjkMa864r6q0Btpfb4WLn35eTHLXOI7ao6vJYMays9XhOnZ0lefZrbAu+J5yHLLkC0+wqIPZnkqbGbZd9MvopVAMYl6t68RSTRyGUeN4odVe5Wl9gMLQRSpopqhlbrJquXM7W63dg0UQ6CKocFj8mm53yWAE9E82Ut+rBz4q0aSxuDGnGrBrtoSq3XbUKelrpHC/679IDb1Jem50FvJeuO6IWVp+E4V1dGmmTrmUHyZycnJycHBx/AT32z/iMKPS/AAAAAElFTkSuQmCC",
    rgbColor: [255, 30, 30]
)
let campingActivity = Activity(name: "Camping", icon: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAADA0lEQVR4nO2Z34tNURTHPzJ+jJLkwa+ZJk+k8AeIaF5RJl5I8jLlR8lM04zQINeDofgTXD+aK+UVNcqzN2FQQxJFzC9ccTVXq/ap1erce88+59wfw/3W6p591o+z1t577bX3vtBEE038d7gATLjfWYctwAxQdLSdWYR5wDPlfNG15X1ctAN3gWlH94C1VAm9xvmAehI4/zXE3rjjpYpVroeCjzxRz9OO7wvp+WIJupN2ALfNtGk30+lWDJu6QyxNpen8NpW4M65d7n0aAUxWK3FlJMqNjE9CS8KWCiBXjcQNm+s2N3wSWlab8RDnvwBtaThvnZNgKgU55ZnQ7S5hpxzl0nJecKPMEJejLA2CiZgByNreEDgL5D2dzzu9hsF64LdycLfhdyleAdhAg+G+cnAkgUxd0BWxdyuNUl2wEHijnLpaQf6akn0HLKLOOGNWlWUV5JcCn5XOaeqINuC7cqY7ol63WY06qBNuxlz/LYkdjYvAz4i6b5McbML2J0kL2hzgm6f+lVoWsLCCNmjsZjxGoAg8JQGWm61EfwX5/gQbugDrTAByxlhJChu518CCCvLzgRcJN3S9IaOwP47zW83VSWdEvU7Te2LHByMhAVz3db7Fzb3AwLCn/rCZw2IvCpaoal5wVHQLioxuZPQoB2TVWO0ZwAqXA4GNExH1Dikd2Vs9UO0dPh+fVIp9xENfjCuXh0rnAHBQtSUfIyGb0vpvKRuh4wpO9gew2FFezQSZYjUrYOUKWhhOlci5nHp/vFYFzPeE1gK8V/I7FW+Xev/KVfNUoB1Min3K1hgw1wQ3pvh7abAAxNlRZetwiMwRMwpRl+WaBHBU2fnk7lsFm4CN7rnV8QK5YzRIAB3m0mxA8S4DQ6o9YGrTGuocgOyrHisbo2qvJVPkI/BB5YPwXir5RyZXUgvA58ASUAHYrGzsUTy5VNB/bf3xOKOXReCk/CY5sNipI7363Nx2654+qXj6297IOGczIe+jjsCvkBPX+RC5c0ZmyNWWS0kCaKKJfwl/AdoVMknih5MdAAAAAElFTkSuQmCC", rgbColor: [30, 150, 130])
let ridingActivity = Activity(name: "Riding", icon: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAACXBIWXMAAAsTAAALEwEAmpwYAAABkklEQVR4nO2VvUoDQRSFP20UX8AY8Q9SiFpZWlkKa2EjCHY29qKxFWJhF7SysNAq72Dc+BNtbPMIgp2KuylMY2TgBoZhM5vZzQaLHLgQzt2ZM/feMxMYIh5zQBVoAW0tMsedJvYF3ABngxBuasIbDBD3mnANOABWBiE8K4K/xowLWYjNA7fSZh9YBCaBXeAaeMxCtAC8GdWFwE4WYjZRPS6AZWAfqADvwDMpsRAj2i3qaYWrXTZuAFfAC/AhVVakajX7vt7XtkQZGI9ZtykGbIoX1G/PRfghQljNb8my5tQygpLLm1yP2EC90SfAWESlKv8DHAJTEkfCtV0rXwUugcA4wBMwon1XE16JmihKTrXdGWq229Lujvialg+Fy0WszUlOHT6VOV5lo3ON63REtddEPk64V3PsCaeu0qhwvnBqpiaOba12MccE8CncunCetr4oVeZFtGUzl6s5ytrd7qCU5DoFjjOakX+lLeNbTw4Y9vqABBbhacl9kwH8pOZICy+pOfqBUj/e2qTwXM0xxL/GH2fky70xRk+YAAAAAElFTkSuQmCC", rgbColor: [30, 30, 255])
let bikingActivity = Activity(name: "Biking", icon: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAACXBIWXMAAAsTAAALEwEAmpwYAAADmklEQVR4nO2YOWhVQRSGP7O5r9goqJ2IBhTEwkI0YOOCRjEKFhJsxD2xEhvRQoOggkulhRi3ylJEOwUR3HdNTERR1MYtcddEJvwjk5c7903ue94g3B+Gd+8s5z9nzsw5513IkCFDhgwZMvQJbgJ3genAWGAkMIz/1JBOT7uclhLHgbfAO097GCDD7P5e4CnwMcKY0SnYwY8I4p/AG+ACsKAA2dclbyYp4BrwHjgFNIm4tkiyj0neWlJAqfO8UsTNQFkRZNdJ3lFShjHqcRG9MkeybtEHWBUTgZK2H8CAtA2p/QeGdAKz0j5aTxzypwXclYM5hmwjRax2LntzAXdli9a2K7+Y5/OkhHKgxVG+NqFXTN75BfwGqoExktNWpEhIBbBc+eKxdqtdO98IHMoJvWUJvDID+Kw19c4GvVRfi8NrdDgpnYxuQVjq7Ha+tsdZV9uLvDIBeK35h9VnPPIsgNN4fUmc8BIpZhfcATYBk4HBwCBgInDamdMB7NDaUK8MB+5r3jl5YZ8j861+r4rXtCnAZlXNdl6DeHvAGvENWOOZ5Cp7VnWWed4Z6JVy1WR2o4YC+/X+FVgPjFIuMW1ExGavlY7WmB7HyRoxO2Y3cxWdL2OMZxYGeOWIxl4B43RErBFVzryL6jdlkK8KsMaYI9mFCudOGE/44FPShs9H2jGfV7Y6Ydb8qeoPPPcUihvUfyZGn3UOj/F0VySwro48c4JPwVKnEl7iMbhGXjNhdrH6VmjO7Qje8Zr/ISZKGd57krEMhdhOXWwf8h2ZzRo7EmG0KTe+5IRZtNud2tko3ND43ICK+QROmWGikw/5LvFUjd+LMPx7Tpi1aFX/JA/ndo0fiNFriuaYPMMnvZgI4oMt15O2cxEbYL000MM5TeMmt/gwVHM+hRpyqQAjrnhkh/DeBl7E3N1uhoQcrXyolIyQjw8WIbyDYjzm8nYdrZN6MRc2KTZJhvnKEopi8NZLRqMbfu/mCb8+lDglhw2tISiUt9Th7Qq/FSrEohJTCDZqbWsvS+9CeTdobZNNiDilwjel/1DMdUqFeQmUScpbpbBukuai3MEGR+i6nE8/uSiRJ75qze4ERiThLZUnbG7a5VPOCrXJrU5JZ4jK6Upd7AdOGW+q5n4FGJKPd4h465070SEjYu9WtZOV41pzlFsLQChvU294yxUJTqiqbVPV+kShrqZY/6kDeNuUnxo19vdiZ8iQIUOGDBnojj9dy789FN0xZAAAAABJRU5ErkJggg==", rgbColor: [30, 100, 255])

let mockActivities = [trekkingActivity, campingActivity, ridingActivity, bikingActivity]

/// LocationActivity
let mockLocationSummary1 = LocationSummary(
    id: UUID(),
    title: "Bhandardara Dam",
    date: Date(),
    images: [
        "https://images.pexels.com/photos/6638603/pexels-photo-6638603.jpeg?auto=compress&cs=tinysrgb&w=600",
        "https://images.pexels.com/photos/2699258/pexels-photo-2699258.jpeg?auto=compress&cs=tinysrgb&w=600",
        "https://images.pexels.com/photos/1633943/pexels-photo-1633943.jpeg?auto=compress&cs=tinysrgb&w=600"
    ],
    bookmarks: 40,
    activities: [campingActivity],
    location: LocationCoordinates(
        lat: 19.54738325316985,
        long: 73.7573012385777
    )
)
let mockLocationSummary2 = LocationSummary(
    id: UUID(),
    title: "Devbag Beach",
    date: Date().addingTimeInterval(-6000),
    images: [
        "https://images.pexels.com/photos/2496880/pexels-photo-2496880.jpeg?auto=compress&cs=tinysrgb&w=600",
        "https://images.pexels.com/photos/1212600/pexels-photo-1212600.jpeg?auto=compress&cs=tinysrgb&w=600",
        "https://images.pexels.com/photos/87812/pexels-photo-87812.jpeg?auto=compress&cs=tinysrgb&w=600",
        "https://images.pexels.com/photos/585759/pexels-photo-585759.jpeg?auto=compress&cs=tinysrgb&w=600"
    ],
    bookmarks: 65,
    activities: [
        trekkingActivity,
        bikingActivity,
    ],
    location: LocationCoordinates(
        lat: 15.968600491744272,
        long: 73.5008954023122
    )
)
let mockLocationSummary3 = LocationSummary(
    id: UUID(),
    title: "Harishchandragad",
    date: Date().addingTimeInterval(-3600000),
    images: [
        "https://images.pexels.com/photos/1365425/pexels-photo-1365425.jpeg?auto=compress&cs=tinysrgb&w=600",
        "https://images.pexels.com/photos/450062/pexels-photo-450062.jpeg?auto=compress&cs=tinysrgb&w=600",
        "https://images.pexels.com/photos/2534618/pexels-photo-2534618.jpeg?auto=compress&cs=tinysrgb&w=600"
    ],
    bookmarks: 65,
    activities: [
        campingActivity,
        ridingActivity,
    ],
    location: LocationCoordinates(
        lat: 15.968600491744272,
        long: 73.5008954023122
    )
)

let mockLocationActivities = [mockLocationSummary1, mockLocationSummary2, mockLocationSummary3]
