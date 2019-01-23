# frozen_string_literal: true

BRAND = 'Conversa'
BRAND_SHORT = 'Conversa'

COMPANY = 'Conversa.cc'
WEBSITE = 'conversa.cc'

STANDARD_EMAIL_REGEX = /\A[a-z0-9_\-\.%+]+@[a-z0-9\-\.]+\.[a-z]+\Z/i.freeze

POBOX_REGEX = /P(ost|\.)?\s*O(ffice|ff|ff\.|\.)?\s*B(ox|\.)?/i.freeze

Time::DATE_FORMATS[:standard] = '%B %e, %Y at %l:%M %p %Z'
Time::DATE_FORMATS[:date_only] = '%-1m/%-1e/%Y'
Time::DATE_FORMATS[:month_and_year] = '%m/%y'

Date::DATE_FORMATS[:standard] = '%B %e, %Y'

IMAGE_MIME_TYPES = ['image/jpeg', 'image/jpg', 'image/pjpeg',
                    'image/gif', 'image/png'].freeze
