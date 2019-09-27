require 'rails_helper'

# Test suite for the Item model
RSpec.describe Appointment, type: :model do
  it { should belong_to(:user) }
end
